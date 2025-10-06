lexer grammar FlexLexer;

// 关键字
IF
    : 'if'
    ;
ELSE: 'else';
WHILE: 'while';

// 标识符和字面量
ID: [a-zA-Z_][a-zA-Z_0-9]*;
NUMBER: [0-9]+;

// 空白字符
WS: [ \t\r\n]+ -> skip;