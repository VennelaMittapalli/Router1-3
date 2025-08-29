class source_agent extends uvm_agent;
        `uvm_component_utils(source_agent)

        source_sequencer s_seqr;
        source_driver s_drv;
        source_monitor s_mon;
        source_agent_config s_cfg;

        function new(string name = "source_agent", uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(source_agent_config)::get(this,"","source_agent_config",s_cfg))
                        `uvm_fatal("FATAL_ERROR","Unable to fetch config file")
                super.build_phase(phase);
                s_mon = source_monitor::type_id::create("s_mon",this);
                if(s_cfg.is_active == UVM_ACTIVE) begin
                        s_seqr = source_sequencer::type_id::create("s_seqr",this);
                        s_drv = source_driver::type_id::create("s_drv",this);
                end
        endfunction

        function void connect_phase(uvm_phase phase);
//              super.connect_phase(phase);
                if(s_cfg.is_active == UVM_ACTIVE)
                        s_drv.seq_item_port.connect(s_seqr.seq_item_export);
        endfunction


endclass
