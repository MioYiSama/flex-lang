parser grammar FlexParser;

options { tokenVocab=FlexLexer; }

program: NUMBER;