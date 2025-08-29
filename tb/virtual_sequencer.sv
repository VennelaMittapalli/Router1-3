class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
        `uvm_component_utils(virtual_sequencer)
        source_sequencer s_seqr[];
        destination_sequencer d_seqr[];
        env_config e_cfg;

        function new(string name="virtual_sequencer", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                        `uvm_fatal("FARAL ERROR","unable to fetch the configuration")
                s_seqr = new[e_cfg.no_of_src_agent];
                d_seqr = new[e_cfg.no_of_dst_agent];
        endfunction
endclass
~
~
~
