CFLAGS  := -Isource/
LDFLAGS := -ltree-sitter -ltree-sitter-markdown -lpcre

OUT := ts-md2html

main: source/main.tbsp
	tbsp -o object/main.tb.c source/main.tbsp
	${CC} ${CFLAGS} -o ${OUT} object/main.tb.c source/sds.c ${LDFLAGS}

test:
	ts-md2html test/max.md

clean:
	-${RM} object/*.c
	-${RM} ${OUT}

.PHONY: test clean
