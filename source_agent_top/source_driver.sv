class source_driver extends uvm_driver#(source_xtn);
        `uvm_component_utils(source_driver)
        virtual router_if.SDRV vif;
        source_agent_config s_cfg;

        function new(string name="source_driver", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(source_agent_config)::get(this,"","source_agent_config",s_cfg))
                        `uvm_fatal("FATAL ERROR","Unable to fetch the config file")
                super.build_phase(phase);
        endfunction

        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                vif = s_cfg.vif;
        endfunction

        task run_phase(uvm_phase phase);
        @(vif.s_drv_cb);
        vif.s_drv_cb.resetn <= 1'b0;
        @(vif.s_drv_cb);
        vif.s_drv_cb.resetn <= 1'b1;
        forever begin
                seq_item_port.get_next_item(req);
                send_to_dut(req);
                seq_item_port.item_done();
        end
        endtask

        task send_to_dut(source_xtn req);
                wait(vif.s_drv_cb.busy == 1'b0)
                vif.s_drv_cb.pkt_valid <= 1'b1;
                vif.s_drv_cb.data_in <= req.header;
                @(vif.s_drv_cb);
                for(int i=0;i<req.header[7:2];i++) begin
                        wait(vif.s_drv_cb.busy == 1'b0)
                        vif.s_drv_cb.data_in <= req.payload[i];
                        @(vif.s_drv_cb);
                end
//              vif.s_drv_cb.pkt_valid <= 1'b0;
                wait(vif.s_drv_cb.busy == 1'b0)
                vif.s_drv_cb.pkt_valid <= 1'b0;
        //      @(vif.s_drv_cb);
                vif.s_drv_cb.data_in <= req.parity;
                          req.print();
        endtask

endclass
          
