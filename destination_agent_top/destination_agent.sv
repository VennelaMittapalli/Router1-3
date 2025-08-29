class destination_agent extends uvm_agent;
        `uvm_component_utils(destination_agent)

        destination_sequencer d_seqr;
        destination_driver d_drv;
        destination_monitor d_mon;
        destination_agent_config d_cfg;

        function new(string name = "destination_agent", uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(destination_agent_config)::get(this,"","destination_agent_config",d_cfg))
                        `uvm_fatal("FATAL_ERROR","Unable to fetch config file")
                super.build_phase(phase);
                d_mon = destination_monitor::type_id::create("d_mon",this);
                if(d_cfg.is_active == UVM_ACTIVE) begin
                        d_seqr = destination_sequencer::type_id::create("d_seqr",this);
                        d_drv = destination_driver::type_id::create("d_drv",this);
                end
        endfunction

        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                if(d_cfg.is_active == UVM_ACTIVE)
                        d_drv.seq_item_port.connect(d_seqr.seq_item_export);
        endfunction


endclass
~
~
