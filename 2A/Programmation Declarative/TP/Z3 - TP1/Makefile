# Le chemin vers Z3 est positionné vers un répertoire partagé.
# Vous pouvez modifier cette variable d'environnement si vous
# avez installé Z3 sur votre compte ou sur votre machine
# personnelle.
PATH_TO_Z3 = z3/bin

JAVAC = javac
JAVA = LD_LIBRARY_PATH=$(PATH_TO_Z3) java
CP_OPTS = -cp $$CLASSPATH:$(PATH_TO_Z3)/com.microsoft.z3.jar
JAVAC_OPTS = $(CP_OPTS) -d classes
JAVA_OPTS = $(CP_OPTS):./classes -Djava.library.path=$(PATH_TO_Z3)
SRC_DIR = src/fr/n7/smt

_SRC_FILES = SimpleIntegerProblem.java SimpleBVProblem.java CheckingOverflowBV.java \
	SimpleArrayProblem.java Sudoku.java
SRC_FILES = $(patsubst %,$(SRC_DIR)/%,$(_SRC_FILES))

.PHONY: compile run-example-int run-example-bv run-example-overflow \
	run-example-array run-sudoku

compile: $(SRC_FILES) | classes
	$(JAVAC) $(JAVAC_OPTS) $^

run-example-int:
	$(JAVAC) $(JAVAC_OPTS) $(SRC_DIR)/SimpleIntegerProblem.java
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.SimpleIntegerProblem

run-example-bv: compile
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.SimpleBVProblem

run-example-overflow: compile
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.CheckingOverflowBV

run-example-array: compile
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.SimpleArrayProblem

run-sudoku:
	$(JAVAC) $(JAVAC_OPTS) $(SRC_DIR)/Sudoku.java
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.Sudoku $(SUDOKU_FILE)

classes:
	mkdir -p $@

clean:
	- rm -rf classes *.log **/*~
