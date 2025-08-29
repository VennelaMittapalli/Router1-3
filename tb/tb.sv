class tb extends uvm_env;
        `uvm_component_utils(tb)

        source_agent_top s_agt_top;
        destination_agent_top d_agt_top;
        env_config e_cfg;
        scoreboard sb;
        virtual_sequencer v_seqr;

        function new(string name = "tb", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                        `uvm_fatal("FATAL ERROR","Unable to fetch env config")
                super.build_phase(phase);
                sb = scoreboard::type_id::create("sb",this);
                v_seqr = virtual_sequencer::type_id::create("v_seqr",this);
                s_agt_top= source_agent_top::type_id::create("s_agt_top",this);

                d_agt_top = destination_agent_top::type_id::create("d_agt_top",this);
        endfunction

        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                foreach(v_seqr.s_seqr[i]) v_seqr.s_seqr[i] = s_agt_top.s_agt[i].s_seqr;
                foreach(v_seqr.d_seqr[i]) v_seqr.d_seqr[i] = d_agt_top.d_agt[i].d_seqr;

        foreach(s_agt_top.s_agt[i]) s_agt_top.s_agt[i].s_mon.ap.connect(sb.src_fifo[i].analysis_export);
        foreach(d_agt_top.d_agt[i]) d_agt_top.d_agt[i].d_mon.ap.connect(sb.dst_fifo[i].analysis_export);
        endfunction


endclass

