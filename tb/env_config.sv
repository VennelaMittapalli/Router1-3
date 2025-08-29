class env_config extends uvm_object;
        `uvm_object_utils(env_config)
        function new(string name="env_config");
                super.new(name);
        endfunction

        source_agent_config src_cfg[];
        destination_agent_config dst_cfg[];

        int no_of_src_agent,no_of_dst_agent;

endclass
~
