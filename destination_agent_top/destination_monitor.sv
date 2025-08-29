class destination_monitor extends uvm_monitor;
        `uvm_component_utils(destination_monitor)

        uvm_analysis_port #(destination_xtn) ap;
        virtual router_if.DMON vif;
        destination_agent_config d_cfg;
        destination_xtn xtn;

        function new(string name="destination_monitor", uvm_component parent);
                super.new(name,parent);
                ap = new("ap",this);
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
                forever collect_data();
        endtask

        task collect_data();
                xtn = destination_xtn::type_id::create("destination_xtn");
                wait(vif.d_mon_cb.read_enb && vif.d_mon_cb.valid_out)
                @(vif.d_mon_cb);
                xtn.header = vif.d_mon_cb.data_out;
                xtn.payload = new[xtn.header[7:2]];
                @(vif.d_mon_cb);
                $display("DESTINATION MONTOR");
                foreach(xtn.payload[i])
                        begin
                                wait(vif.d_mon_cb.read_enb && vif.d_mon_cb.valid_out)
                                xtn.payload[i] = vif.d_mon_cb.data_out;
                                @(vif.d_mon_cb);
                        end
                $display("DESTINATON MONITOR HELLO");
                wait(vif.d_mon_cb.read_enb && ~vif.d_mon_cb.valid_out)
                xtn.parity = vif.d_mon_cb.data_out;
                $display("DESTINATON MONITOR");
                xtn.print();
                ap.write(xtn);
        endtask
endclass

"destination_monitor.sv" 51L, 1998C                    
