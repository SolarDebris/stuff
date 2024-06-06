import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.*;


public class Example extends GhidraScript {
    @Override 
    public void run() throws Exception {
        Program program = getCurrentProgram();
        SymbolTable symbols = program.getSymbolTable();
        ReferenceManager references = program.getReferenceManager();
        ProgramBasedDataTypeManager dataTypes = program.getDataTypeManager();
        FunctionManager functions = program.getFunctionManager();
        Memory memory = program.getMemory();
        BookmarkManager bookmarks = program.getBookmarkManager();
        
    
        
        println("Running ghidrascript");
    }
}
