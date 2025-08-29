class destination_driver extends uvm_driver#(destination_xtn);
        `uvm_component_utils(destination_driver)
        virtual router_if.DDRV vif;
        destination_agent_config d_cfg;

        function new(string name="destination_driver", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(destination_agent_config)::get(this,"","destination_agent_config",d_cfg))
                        `uvm_fatal("FATAL ERROR","Unable to fetch the config file")
                super.build_phase(phase);
        endfunction

        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                vif = d_cfg.vif;
        endfunction

        task run_phase(uvm_phase phase);
        forever begin
                seq_item_port.get_next_item(req);
                send_to_dut(req);
                seq_item_port.item_done();
        end
        endtask

        task send_to_dut(destination_xtn req);
                wait(vif.d_drv_cb.valid_out)
                $display("%0d",req.no_of_cycles);
                repeat(req.no_of_cycles) @(vif.d_drv_cb);
                vif.d_drv_cb.read_enb <= 1'b1;
                @(vif.d_drv_cb);

                wait(~vif.d_drv_cb.valid_out)
                $display("HI");
                @(vif.d_drv_cb);
                vif.d_drv_cb.read_enb <= 1'b0;
                `uvm_info("INFO",get_full_name(), UVM_NONE)
        endtask

endclass
