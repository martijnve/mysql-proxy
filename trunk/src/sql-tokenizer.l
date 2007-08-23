	#include <stdio.h>

	#include "sql-tokenizer.h"

	#define YY_DECL int sql_tokenizer_internal(GPtrArray *tokens)

	sql_token *sql_token_new(void) {
		sql_token *tk;

		tk = g_new0(sql_token, 1);
		tk->text = g_string_new(NULL);
		tk->token_id = TK_UNKNOWN;

		return tk;
	}
	
	void sql_token_free(sql_token *token) {
		if (!token) return;

		g_string_free(token->text, TRUE);
		g_free(token);		
	}

	void sql_token_append(GPtrArray *tokens, sql_token_id token_id, gchar *text) {
		sql_token *token;

		token = sql_token_new();
		token->token_id = token_id;
		g_string_assign(token->text, text);
		g_ptr_array_add(tokens, token);
	}

	void sql_token_append_last_token(GPtrArray *tokens, sql_token_id token_id, gchar *text) {
		sql_token *token;

		g_assert(tokens->len > 0);

		token = tokens->pdata[tokens->len - 1];
		g_assert(token);
		g_assert(token->token_id == token_id);

		g_string_append(token->text, text);
	}

%option case-insensitive
%option noyywrap
%x COMMENT QUOTED
%%

	/** keywords */
	/** a generated list of tokens */

"ACCESSIBLE"	sql_token_append(tokens, TK_SQL_ACCESSIBLE, yytext);
"ACTION"	sql_token_append(tokens, TK_SQL_ACTION, yytext);
"ADD"		sql_token_append(tokens, TK_SQL_ADD, yytext);
"ALL"		sql_token_append(tokens, TK_SQL_ALL, yytext);
"ALTER"		sql_token_append(tokens, TK_SQL_ALTER, yytext);
"ANALYZE"	sql_token_append(tokens, TK_SQL_ANALYZE, yytext);
"AND"		sql_token_append(tokens, TK_SQL_AND, yytext);
"AS"		sql_token_append(tokens, TK_SQL_AS, yytext);
"ASC"		sql_token_append(tokens, TK_SQL_ASC, yytext);
"ASENSITIVE"	sql_token_append(tokens, TK_SQL_ASENSITIVE, yytext);
"BEFORE"	sql_token_append(tokens, TK_SQL_BEFORE, yytext);
"BETWEEN"	sql_token_append(tokens, TK_SQL_BETWEEN, yytext);
"BIGINT"	sql_token_append(tokens, TK_SQL_BIGINT, yytext);
"BINARY"	sql_token_append(tokens, TK_SQL_BINARY, yytext);
"BIT"		sql_token_append(tokens, TK_SQL_BIT, yytext);
"BLOB"		sql_token_append(tokens, TK_SQL_BLOB, yytext);
"BOTH"		sql_token_append(tokens, TK_SQL_BOTH, yytext);
"BY"		sql_token_append(tokens, TK_SQL_BY, yytext);
"CALL"		sql_token_append(tokens, TK_SQL_CALL, yytext);
"CASCADE"	sql_token_append(tokens, TK_SQL_CASCADE, yytext);
"CASE"		sql_token_append(tokens, TK_SQL_CASE, yytext);
"CHANGE"	sql_token_append(tokens, TK_SQL_CHANGE, yytext);
"CHAR"		sql_token_append(tokens, TK_SQL_CHAR, yytext);
"CHARACTER"	sql_token_append(tokens, TK_SQL_CHARACTER, yytext);
"CHECK"		sql_token_append(tokens, TK_SQL_CHECK, yytext);
"COLLATE"	sql_token_append(tokens, TK_SQL_COLLATE, yytext);
"COLUMN"	sql_token_append(tokens, TK_SQL_COLUMN, yytext);
"CONDITION"	sql_token_append(tokens, TK_SQL_CONDITION, yytext);
"CONSTRAINT"	sql_token_append(tokens, TK_SQL_CONSTRAINT, yytext);
"CONTINUE"	sql_token_append(tokens, TK_SQL_CONTINUE, yytext);
"CONVERT"	sql_token_append(tokens, TK_SQL_CONVERT, yytext);
"CREATE"	sql_token_append(tokens, TK_SQL_CREATE, yytext);
"CROSS"		sql_token_append(tokens, TK_SQL_CROSS, yytext);
"CURRENT_DATE"	sql_token_append(tokens, TK_SQL_CURRENT_DATE, yytext);
"CURRENT_TIME"	sql_token_append(tokens, TK_SQL_CURRENT_TIME, yytext);
"CURRENT_TIMESTAMP"	sql_token_append(tokens, TK_SQL_CURRENT_TIMESTAMP, yytext);
"CURRENT_USER"	sql_token_append(tokens, TK_SQL_CURRENT_USER, yytext);
"CURSOR"	sql_token_append(tokens, TK_SQL_CURSOR, yytext);
"DATABASE"	sql_token_append(tokens, TK_SQL_DATABASE, yytext);
"DATABASES"	sql_token_append(tokens, TK_SQL_DATABASES, yytext);
"DATE"		sql_token_append(tokens, TK_SQL_DATE, yytext);
"DAY_HOUR"	sql_token_append(tokens, TK_SQL_DAY_HOUR, yytext);
"DAY_MICROSECOND"	sql_token_append(tokens, TK_SQL_DAY_MICROSECOND, yytext);
"DAY_MINUTE"	sql_token_append(tokens, TK_SQL_DAY_MINUTE, yytext);
"DAY_SECOND"	sql_token_append(tokens, TK_SQL_DAY_SECOND, yytext);
"DEC"		sql_token_append(tokens, TK_SQL_DEC, yytext);
"DECIMAL"	sql_token_append(tokens, TK_SQL_DECIMAL, yytext);
"DECLARE"	sql_token_append(tokens, TK_SQL_DECLARE, yytext);
"DEFAULT"	sql_token_append(tokens, TK_SQL_DEFAULT, yytext);
"DELAYED"	sql_token_append(tokens, TK_SQL_DELAYED, yytext);
"DELETE"	sql_token_append(tokens, TK_SQL_DELETE, yytext);
"DESC"		sql_token_append(tokens, TK_SQL_DESC, yytext);
"DESCRIBE"	sql_token_append(tokens, TK_SQL_DESCRIBE, yytext);
"DETERMINISTIC"	sql_token_append(tokens, TK_SQL_DETERMINISTIC, yytext);
"DISTINCT"	sql_token_append(tokens, TK_SQL_DISTINCT, yytext);
"DISTINCTROW"	sql_token_append(tokens, TK_SQL_DISTINCTROW, yytext);
"DIV"		sql_token_append(tokens, TK_SQL_DIV, yytext);
"DOUBLE"	sql_token_append(tokens, TK_SQL_DOUBLE, yytext);
"DROP"		sql_token_append(tokens, TK_SQL_DROP, yytext);
"DUAL"		sql_token_append(tokens, TK_SQL_DUAL, yytext);
"EACH"		sql_token_append(tokens, TK_SQL_EACH, yytext);
"ELSE"		sql_token_append(tokens, TK_SQL_ELSE, yytext);
"ELSEIF"	sql_token_append(tokens, TK_SQL_ELSEIF, yytext);
"ENCLOSED"	sql_token_append(tokens, TK_SQL_ENCLOSED, yytext);
"ENUM"		sql_token_append(tokens, TK_SQL_ENUM, yytext);
"ESCAPED"	sql_token_append(tokens, TK_SQL_ESCAPED, yytext);
"EXISTS"	sql_token_append(tokens, TK_SQL_EXISTS, yytext);
"EXIT"		sql_token_append(tokens, TK_SQL_EXIT, yytext);
"EXPLAIN"	sql_token_append(tokens, TK_SQL_EXPLAIN, yytext);
"FALSE"		sql_token_append(tokens, TK_SQL_FALSE, yytext);
"FETCH"		sql_token_append(tokens, TK_SQL_FETCH, yytext);
"FLOAT"		sql_token_append(tokens, TK_SQL_FLOAT, yytext);
"FLOAT4"	sql_token_append(tokens, TK_SQL_FLOAT4, yytext);
"FLOAT8"	sql_token_append(tokens, TK_SQL_FLOAT8, yytext);
"FOR"		sql_token_append(tokens, TK_SQL_FOR, yytext);
"FORCE"		sql_token_append(tokens, TK_SQL_FORCE, yytext);
"FOREIGN"	sql_token_append(tokens, TK_SQL_FOREIGN, yytext);
"FROM"		sql_token_append(tokens, TK_SQL_FROM, yytext);
"FULLTEXT"	sql_token_append(tokens, TK_SQL_FULLTEXT, yytext);
"GRANT"		sql_token_append(tokens, TK_SQL_GRANT, yytext);
"GROUP"		sql_token_append(tokens, TK_SQL_GROUP, yytext);
"HAVING"	sql_token_append(tokens, TK_SQL_HAVING, yytext);
"HIGH_PRIORITY"	sql_token_append(tokens, TK_SQL_HIGH_PRIORITY, yytext);
"HOUR_MICROSECOND"	sql_token_append(tokens, TK_SQL_HOUR_MICROSECOND, yytext);
"HOUR_MINUTE"	sql_token_append(tokens, TK_SQL_HOUR_MINUTE, yytext);
"HOUR_SECOND"	sql_token_append(tokens, TK_SQL_HOUR_SECOND, yytext);
"IF"		sql_token_append(tokens, TK_SQL_IF, yytext);
"IGNORE"	sql_token_append(tokens, TK_SQL_IGNORE, yytext);
"IN"		sql_token_append(tokens, TK_SQL_IN, yytext);
"INDEX"		sql_token_append(tokens, TK_SQL_INDEX, yytext);
"INFILE"	sql_token_append(tokens, TK_SQL_INFILE, yytext);
"INNER"		sql_token_append(tokens, TK_SQL_INNER, yytext);
"INOUT"		sql_token_append(tokens, TK_SQL_INOUT, yytext);
"INSENSITIVE"	sql_token_append(tokens, TK_SQL_INSENSITIVE, yytext);
"INSERT"	sql_token_append(tokens, TK_SQL_INSERT, yytext);
"INT"		sql_token_append(tokens, TK_SQL_INT, yytext);
"INT1"		sql_token_append(tokens, TK_SQL_INT1, yytext);
"INT2"		sql_token_append(tokens, TK_SQL_INT2, yytext);
"INT3"		sql_token_append(tokens, TK_SQL_INT3, yytext);
"INT4"		sql_token_append(tokens, TK_SQL_INT4, yytext);
"INT8"		sql_token_append(tokens, TK_SQL_INT8, yytext);
"INTEGER"	sql_token_append(tokens, TK_SQL_INTEGER, yytext);
"INTERVAL"	sql_token_append(tokens, TK_SQL_INTERVAL, yytext);
"INTO"		sql_token_append(tokens, TK_SQL_INTO, yytext);
"IS"		sql_token_append(tokens, TK_SQL_IS, yytext);
"ITERATE"	sql_token_append(tokens, TK_SQL_ITERATE, yytext);
"JOIN"		sql_token_append(tokens, TK_SQL_JOIN, yytext);
"KEY"		sql_token_append(tokens, TK_SQL_KEY, yytext);
"KEYS"		sql_token_append(tokens, TK_SQL_KEYS, yytext);
"KILL"		sql_token_append(tokens, TK_SQL_KILL, yytext);
"LEADING"	sql_token_append(tokens, TK_SQL_LEADING, yytext);
"LEAVE"		sql_token_append(tokens, TK_SQL_LEAVE, yytext);
"LEFT"		sql_token_append(tokens, TK_SQL_LEFT, yytext);
"LIKE"		sql_token_append(tokens, TK_SQL_LIKE, yytext);
"LIMIT"		sql_token_append(tokens, TK_SQL_LIMIT, yytext);
"LINEAR"	sql_token_append(tokens, TK_SQL_LINEAR, yytext);
"LINES"		sql_token_append(tokens, TK_SQL_LINES, yytext);
"LOAD"		sql_token_append(tokens, TK_SQL_LOAD, yytext);
"LOCALTIME"	sql_token_append(tokens, TK_SQL_LOCALTIME, yytext);
"LOCALTIMESTAMP"	sql_token_append(tokens, TK_SQL_LOCALTIMESTAMP, yytext);
"LOCK"		sql_token_append(tokens, TK_SQL_LOCK, yytext);
"LONG"		sql_token_append(tokens, TK_SQL_LONG, yytext);
"LONGBLOB"	sql_token_append(tokens, TK_SQL_LONGBLOB, yytext);
"LONGTEXT"	sql_token_append(tokens, TK_SQL_LONGTEXT, yytext);
"LOOP"		sql_token_append(tokens, TK_SQL_LOOP, yytext);
"LOW_PRIORITY"	sql_token_append(tokens, TK_SQL_LOW_PRIORITY, yytext);
"MASTER_SSL_VERIFY_SERVER_CERT"	sql_token_append(tokens, TK_SQL_MASTER_SSL_VERIFY_SERVER_CERT, yytext);
"MATCH"		sql_token_append(tokens, TK_SQL_MATCH, yytext);
"MEDIUMBLOB"	sql_token_append(tokens, TK_SQL_MEDIUMBLOB, yytext);
"MEDIUMINT"	sql_token_append(tokens, TK_SQL_MEDIUMINT, yytext);
"MEDIUMTEXT"	sql_token_append(tokens, TK_SQL_MEDIUMTEXT, yytext);
"MIDDLEINT"	sql_token_append(tokens, TK_SQL_MIDDLEINT, yytext);
"MINUTE_MICROSECOND"	sql_token_append(tokens, TK_SQL_MINUTE_MICROSECOND, yytext);
"MINUTE_SECOND"	sql_token_append(tokens, TK_SQL_MINUTE_SECOND, yytext);
"MOD"		sql_token_append(tokens, TK_SQL_MOD, yytext);
"MODIFIES"	sql_token_append(tokens, TK_SQL_MODIFIES, yytext);
"NATURAL"	sql_token_append(tokens, TK_SQL_NATURAL, yytext);
"NO"		sql_token_append(tokens, TK_SQL_NO, yytext);
"NOT"		sql_token_append(tokens, TK_SQL_NOT, yytext);
"NO_WRITE_TO_BINLOG"	sql_token_append(tokens, TK_SQL_NO_WRITE_TO_BINLOG, yytext);
"NULL"		sql_token_append(tokens, TK_SQL_NULL, yytext);
"NUMERIC"	sql_token_append(tokens, TK_SQL_NUMERIC, yytext);
"ON"		sql_token_append(tokens, TK_SQL_ON, yytext);
"OPTIMIZE"	sql_token_append(tokens, TK_SQL_OPTIMIZE, yytext);
"OPTION"	sql_token_append(tokens, TK_SQL_OPTION, yytext);
"OPTIONALLY"	sql_token_append(tokens, TK_SQL_OPTIONALLY, yytext);
"OR"		sql_token_append(tokens, TK_SQL_OR, yytext);
"ORDER"		sql_token_append(tokens, TK_SQL_ORDER, yytext);
"OUT"		sql_token_append(tokens, TK_SQL_OUT, yytext);
"OUTER"		sql_token_append(tokens, TK_SQL_OUTER, yytext);
"OUTFILE"	sql_token_append(tokens, TK_SQL_OUTFILE, yytext);
"PRECISION"	sql_token_append(tokens, TK_SQL_PRECISION, yytext);
"PRIMARY"	sql_token_append(tokens, TK_SQL_PRIMARY, yytext);
"PROCEDURE"	sql_token_append(tokens, TK_SQL_PROCEDURE, yytext);
"PURGE"		sql_token_append(tokens, TK_SQL_PURGE, yytext);
"RANGE"		sql_token_append(tokens, TK_SQL_RANGE, yytext);
"READ"		sql_token_append(tokens, TK_SQL_READ, yytext);
"READ_ONLY"	sql_token_append(tokens, TK_SQL_READ_ONLY, yytext);
"READS"		sql_token_append(tokens, TK_SQL_READS, yytext);
"READ_WRITE"	sql_token_append(tokens, TK_SQL_READ_WRITE, yytext);
"REAL"		sql_token_append(tokens, TK_SQL_REAL, yytext);
"REFERENCES"	sql_token_append(tokens, TK_SQL_REFERENCES, yytext);
"REGEXP"	sql_token_append(tokens, TK_SQL_REGEXP, yytext);
"RELEASE"	sql_token_append(tokens, TK_SQL_RELEASE, yytext);
"RENAME"	sql_token_append(tokens, TK_SQL_RENAME, yytext);
"REPEAT"	sql_token_append(tokens, TK_SQL_REPEAT, yytext);
"REPLACE"	sql_token_append(tokens, TK_SQL_REPLACE, yytext);
"REQUIRE"	sql_token_append(tokens, TK_SQL_REQUIRE, yytext);
"RESTRICT"	sql_token_append(tokens, TK_SQL_RESTRICT, yytext);
"RETURN"	sql_token_append(tokens, TK_SQL_RETURN, yytext);
"REVOKE"	sql_token_append(tokens, TK_SQL_REVOKE, yytext);
"RIGHT"		sql_token_append(tokens, TK_SQL_RIGHT, yytext);
"RLIKE"		sql_token_append(tokens, TK_SQL_RLIKE, yytext);
"SCHEMA"	sql_token_append(tokens, TK_SQL_SCHEMA, yytext);
"SCHEMAS"	sql_token_append(tokens, TK_SQL_SCHEMAS, yytext);
"SECOND_MICROSECOND"	sql_token_append(tokens, TK_SQL_SECOND_MICROSECOND, yytext);
"SELECT"	sql_token_append(tokens, TK_SQL_SELECT, yytext);
"SENSITIVE"	sql_token_append(tokens, TK_SQL_SENSITIVE, yytext);
"SEPARATOR"	sql_token_append(tokens, TK_SQL_SEPARATOR, yytext);
"SET"		sql_token_append(tokens, TK_SQL_SET, yytext);
"SHOW"		sql_token_append(tokens, TK_SQL_SHOW, yytext);
"SMALLINT"	sql_token_append(tokens, TK_SQL_SMALLINT, yytext);
"SPATIAL"	sql_token_append(tokens, TK_SQL_SPATIAL, yytext);
"SPECIFIC"	sql_token_append(tokens, TK_SQL_SPECIFIC, yytext);
"SQL"		sql_token_append(tokens, TK_SQL_SQL, yytext);
"SQL_BIG_RESULT"	sql_token_append(tokens, TK_SQL_SQL_BIG_RESULT, yytext);
"SQL_CALC_FOUND_ROWS"	sql_token_append(tokens, TK_SQL_SQL_CALC_FOUND_ROWS, yytext);
"SQLEXCEPTION"	sql_token_append(tokens, TK_SQL_SQLEXCEPTION, yytext);
"SQL_SMALL_RESULT"	sql_token_append(tokens, TK_SQL_SQL_SMALL_RESULT, yytext);
"SQLSTATE"	sql_token_append(tokens, TK_SQL_SQLSTATE, yytext);
"SQLWARNING"	sql_token_append(tokens, TK_SQL_SQLWARNING, yytext);
"SSL"		sql_token_append(tokens, TK_SQL_SSL, yytext);
"STARTING"	sql_token_append(tokens, TK_SQL_STARTING, yytext);
"STRAIGHT_JOIN"	sql_token_append(tokens, TK_SQL_STRAIGHT_JOIN, yytext);
"TABLE"		sql_token_append(tokens, TK_SQL_TABLE, yytext);
"TERMINATED"	sql_token_append(tokens, TK_SQL_TERMINATED, yytext);
"TEXT"		sql_token_append(tokens, TK_SQL_TEXT, yytext);
"THEN"		sql_token_append(tokens, TK_SQL_THEN, yytext);
"TIME"		sql_token_append(tokens, TK_SQL_TIME, yytext);
"TIMESTAMP"	sql_token_append(tokens, TK_SQL_TIMESTAMP, yytext);
"TINYBLOB"	sql_token_append(tokens, TK_SQL_TINYBLOB, yytext);
"TINYINT"	sql_token_append(tokens, TK_SQL_TINYINT, yytext);
"TINYTEXT"	sql_token_append(tokens, TK_SQL_TINYTEXT, yytext);
"TO"		sql_token_append(tokens, TK_SQL_TO, yytext);
"TRAILING"	sql_token_append(tokens, TK_SQL_TRAILING, yytext);
"TRIGGER"	sql_token_append(tokens, TK_SQL_TRIGGER, yytext);
"TRUE"		sql_token_append(tokens, TK_SQL_TRUE, yytext);
"UNDO"		sql_token_append(tokens, TK_SQL_UNDO, yytext);
"UNION"		sql_token_append(tokens, TK_SQL_UNION, yytext);
"UNIQUE"	sql_token_append(tokens, TK_SQL_UNIQUE, yytext);
"UNLOCK"	sql_token_append(tokens, TK_SQL_UNLOCK, yytext);
"UNSIGNED"	sql_token_append(tokens, TK_SQL_UNSIGNED, yytext);
"UPDATE"	sql_token_append(tokens, TK_SQL_UPDATE, yytext);
"USAGE"		sql_token_append(tokens, TK_SQL_USAGE, yytext);
"USE"		sql_token_append(tokens, TK_SQL_USE, yytext);
"USING"		sql_token_append(tokens, TK_SQL_USING, yytext);
"UTC_DATE"	sql_token_append(tokens, TK_SQL_UTC_DATE, yytext);
"UTC_TIME"	sql_token_append(tokens, TK_SQL_UTC_TIME, yytext);
"UTC_TIMESTAMP"	sql_token_append(tokens, TK_SQL_UTC_TIMESTAMP, yytext);
"VALUES"	sql_token_append(tokens, TK_SQL_VALUES, yytext);
"VARBINARY"	sql_token_append(tokens, TK_SQL_VARBINARY, yytext);
"VARCHAR"	sql_token_append(tokens, TK_SQL_VARCHAR, yytext);
"VARCHARACTER"	sql_token_append(tokens, TK_SQL_VARCHARACTER, yytext);
"VARYING"	sql_token_append(tokens, TK_SQL_VARYING, yytext);
"WHEN"		sql_token_append(tokens, TK_SQL_WHEN, yytext);
"WHERE"		sql_token_append(tokens, TK_SQL_WHERE, yytext);
"WHILE"		sql_token_append(tokens, TK_SQL_WHILE, yytext);
"WITH"		sql_token_append(tokens, TK_SQL_WITH, yytext);
"WRITE"		sql_token_append(tokens, TK_SQL_WRITE, yytext);
"X509"		sql_token_append(tokens, TK_SQL_X509, yytext);
"XOR"		sql_token_append(tokens, TK_SQL_XOR, yytext);
"YEAR_MONTH"	sql_token_append(tokens, TK_SQL_YEAR_MONTH, yytext);
"ZEROFILL"	sql_token_append(tokens, TK_SQL_ZEROFILL, yytext);

	/** comments */
"/*"		sql_token_append(tokens, TK_COMMENT,    ""); BEGIN(COMMENT);
<COMMENT>[^*]*	sql_token_append_last_token(tokens, TK_COMMENT, yytext);
<COMMENT>"*"+[^*/]*	sql_token_append_last_token(tokens, TK_COMMENT, yytext);
<COMMENT>"*"+"/"	BEGIN(INITIAL);

	/** string quoting */
"\""		sql_token_append(tokens, TK_STRING, ""); BEGIN(QUOTED);
<QUOTED>[^"\\]*	sql_token_append_last_token(tokens, TK_STRING, yytext);
<QUOTED>"\"[^"]	sql_token_append_last_token(tokens, TK_STRING, yytext); /** FIXME: unescape */
<QUOTED>"\"\""	sql_token_append_last_token(tokens, TK_STRING, "\"");
<QUOTED>"\\""\""	sql_token_append_last_token(tokens, TK_STRING, "\"");
<QUOTED>"\""	BEGIN(INITIAL);



	/** strings, quoting, literals */
[[:space:]]+	/** ignore WS */
[[:alpha:]@][[:alnum:]_@]*	sql_token_append(tokens, TK_LITERAL, yytext);
[[:digit:]]+	sql_token_append(tokens, TK_INTEGER, yytext);
[[:digit:]]*"."[[:digit:]]+	sql_token_append(tokens, TK_FLOAT, yytext);
","		sql_token_append(tokens, TK_COMMA, yytext);
"."		sql_token_append(tokens, TK_DOT, yytext);

"<"		sql_token_append(tokens, TK_LT, yytext);
">"		sql_token_append(tokens, TK_GT, yytext);
"<="		sql_token_append(tokens, TK_LE, yytext);
">="		sql_token_append(tokens, TK_GE, yytext);
"="		sql_token_append(tokens, TK_EQ, yytext);
"<>"		sql_token_append(tokens, TK_NE, yytext);
"!="		sql_token_append(tokens, TK_NE, yytext);

"("		sql_token_append(tokens, TK_OBRACE, yytext);
")"		sql_token_append(tokens, TK_CBRACE, yytext);
";"		sql_token_append(tokens, TK_SEMICOLON, yytext);
":="		sql_token_append(tokens, TK_ASSIGN, yytext);

"*"		sql_token_append(tokens, TK_STAR, yytext);
"+"		sql_token_append(tokens, TK_PLUS, yytext);
"/"		sql_token_append(tokens, TK_DIV, yytext);
"-"		sql_token_append(tokens, TK_MINUS, yytext);
	/** the default rule */
.		sql_token_append(tokens, TK_UNKNOWN, yytext);

%%
int sql_tokenizer(GPtrArray *tokens, const gchar *str, gsize len) {
	YY_BUFFER_STATE state;
	int ret;

	state = yy_scan_bytes(str, len);
	ret = sql_tokenizer_internal(tokens);
	yy_delete_buffer(state);

	return ret;
}

#ifdef WITH_MAIN
int main() {
	GPtrArray *tokens = NULL;
	gsize i;

#define C(x) x, sizeof(x) - 1

	tokens = g_ptr_array_new();
	sql_tokenizer(tokens, C("SELEcT * FROM a AS b"));

	for (i = 0; i < tokens->len; i++) {
		sql_token *token = tokens->pdata[i];

		printf("[%"G_GSIZE_FORMAT"] token=%d (%s)\n", i, token->token_id, token->text->str);
	}

	for (i = 0; i < tokens->len; i++) {
		sql_token *token = tokens->pdata[i];

		sql_token_free(token);
	}
	g_ptr_array_free(tokens, TRUE);

	/* cleanup */
	return 0;
}
#endif