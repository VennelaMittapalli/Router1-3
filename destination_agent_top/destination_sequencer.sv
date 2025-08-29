class destination_sequencer extends uvm_sequencer#(destination_xtn);
        `uvm_component_utils(destination_sequencer)
        function new(string name = "destination_sequencer", uvm_component parent);
                super.new(name,parent);
        endfunction
endclass
