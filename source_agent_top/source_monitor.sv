class source_monitor extends uvm_monitor;
        `uvm_component_utils(source_monitor)

        uvm_analysis_port #(source_xtn) ap;
        virtual router_if.SMON vif;
        source_agent_config s_cfg;
        source_xtn xtn;

        function new(string name="source_monitor", uvm_component parent);
                super.new(name,parent);
                ap = new("ap",this);
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
                forever collect_data();
        endtask

        task collect_data();

                xtn = source_xtn::type_id::create("xtn");
//              @(vif.s_mon_cb);
                wait(vif.s_mon_cb.pkt_valid)
                wait( ~vif.s_mon_cb.busy)
//              @(vif.s_mon_cb);
                xtn.header = vif.s_mon_cb.data_in;
                $display("%0d",xtn.header);
                xtn.payload = new[xtn.header[7:2]];
                @(vif.s_mon_cb);
                for(int i =0;i<xtn.header[7:2];i++)begin
                        wait(vif.s_mon_cb.pkt_valid)
                        wait(~vif.s_mon_cb.busy )
//                      $display("%0d",xtn.header[7:2]);
//                      @(vif.s_mon_cb);
                        xtn.payload[i] = vif.s_mon_cb.data_in;
                        @(vif.s_mon_cb);
                end

                wait(~vif.s_mon_cb.pkt_valid)
                wait(~vif.s_mon_cb.busy )
                //@(vif.s_mon_cb);
                xtn.parity = vif.s_mon_cb.data_in;
                @(vif.s_mon_cb);
                @(vif.s_mon_cb);
                xtn.error = vif.s_mon_cb.error;
//              @(vif.s_mon_cb);

                xtn.print();

                ap.write(xtn);
        endtask


endclass

"source_monitor.sv" 71L, 2719C                    
