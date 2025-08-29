class source_agent_top extends uvm_env;
        `uvm_component_utils(source_agent_top)
        env_config e_cfg;
        source_agent_config src_cfg[];
        source_agent s_agt[];

        function new(string name ="source_agent_top", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                        `uvm_fatal("FATAL ERROR","Unable to frtch the env config")
        src_cfg = new[e_cfg.no_of_src_agent];
        s_agt = new[e_cfg.no_of_src_agent];

        foreach(src_cfg[i]) begin
                src_cfg[i] = source_agent_config::type_id::create($sformatf("src_cfg[%0d]",i));
                src_cfg[i] = e_cfg.src_cfg[i];
                s_agt[i] = source_agent::type_id::create($sformatf("s_agt[%0d]",i),this);
                uvm_config_db#(source_agent_config)::set(this,$sformatf("s_agt[%0d]*",i),"source_agent_config",src_cfg[i]);
        end
endfunction
endclass
~
~
