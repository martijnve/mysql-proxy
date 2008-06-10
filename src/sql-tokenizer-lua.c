#include <lua.h>

#include "lua-env.h"
#include "glib-ext.h"

#define C(x) x, sizeof(x) - 1
#define S(x) x->str, x->len

#include "sql-tokenizer.h"
#include "sql-tokenizer-lua.h"

static int proxy_tokenize_token_get(lua_State *L) {
	sql_token *token = *(sql_token **)luaL_checkself(L); 
	size_t keysize;
	const char *key = luaL_checklstring(L, 2, &keysize);

	if (strleq(key, keysize, C("text"))) {
		lua_pushlstring(L, S(token->text));
		return 1;
	} else if (strleq(key, keysize, C("token_id"))) {
		lua_pushinteger(L, token->token_id);
		return 1;
	} else if (strleq(key, keysize, C("token_name"))) {
		lua_pushstring(L, sql_token_get_name(token->token_id));
		return 1;
	}

	return 0;
}

int sql_tokenizer_lua_token_getmetatable(lua_State *L) {
	static const struct luaL_reg methods[] = {
		{ "__index", proxy_tokenize_token_get },
		{ NULL, NULL },
	};
	return proxy_getmetatable(L, methods);
}	


static int proxy_tokenize_get(lua_State *L) {
	GPtrArray *tokens = *(GPtrArray **)luaL_checkself(L); 
	int ndx = luaL_checkinteger(L, 2);
	sql_token *token;
	sql_token **token_p;

	if (tokens->len > G_MAXINT) {
		return 0;
	}

	/* lua uses 1 is starting index */
	if (ndx < 1 && ndx > (int)tokens->len) {
		return 0;
	}

	token = tokens->pdata[ndx - 1];

	token_p = lua_newuserdata(L, sizeof(token));                          /* (sp += 1) */
	*token_p = token;

	sql_tokenizer_lua_token_getmetatable(L);
	lua_setmetatable(L, -2);             /* tie the metatable to the udata   (sp -= 1) */

	return 1;
}

static int proxy_tokenize_len(lua_State *L) {
	GPtrArray *tokens = *(GPtrArray **)luaL_checkself(L); 

	lua_pushinteger(L, tokens->len);

	return 1;
}

static int proxy_tokenize_gc(lua_State *L) {
	GPtrArray *tokens = *(GPtrArray **)luaL_checkself(L); 

	sql_tokens_free(tokens);

	return 0;
}


int sql_tokenizer_lua_getmetatable(lua_State *L) {
	static const struct luaL_reg methods[] = {
		{ "__index", proxy_tokenize_get },
		{ "__len",   proxy_tokenize_len },
		{ "__gc",   proxy_tokenize_gc },
		{ NULL, NULL },
	};
	return proxy_getmetatable(L, methods);
}	

/**
 * split the SQL query into a stream of tokens
 */
int proxy_tokenize(lua_State *L) {
	size_t str_len;
	const char *str = luaL_checklstring(L, 1, &str_len);
	GPtrArray *tokens = sql_tokens_new();
	GPtrArray **tokens_p;

	sql_tokenizer(tokens, str, str_len);

	tokens_p = lua_newuserdata(L, sizeof(tokens));                          /* (sp += 1) */
	*tokens_p = tokens;

	sql_tokenizer_lua_getmetatable(L);
	lua_setmetatable(L, -2);          /* tie the metatable to the udata   (sp -= 1) */

	return 1;
}

