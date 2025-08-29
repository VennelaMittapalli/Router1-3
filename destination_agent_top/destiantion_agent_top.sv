class destination_agent_top extends uvm_env;
        `uvm_component_utils(destination_agent_top)
        env_config e_cfg;
        destination_agent_config dst_cfg[];
        destination_agent d_agt[];

        function new(string name ="destination_agent_top", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                        `uvm_fatal("FATAL ERROR","Unable to frtch the env config")
        dst_cfg = new[e_cfg.no_of_dst_agent];
        d_agt = new[e_cfg.no_of_dst_agent];

        foreach(dst_cfg[i]) begin
                dst_cfg[i] = destination_agent_config::type_id::create($sformatf("dst_cfg[%d]",i));
                dst_cfg[i] = e_cfg.dst_cfg[i];
                d_agt[i] = destination_agent::type_id::create($sformatf("d_agt[%0d]",i),this);
                uvm_config_db#(destination_agent_config)::set(this,$sformatf("d_agt[%0d]*",i),"destination_agent_config",dst_cfg[i]);
        end
endfunction
endclass

