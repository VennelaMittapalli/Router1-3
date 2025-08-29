class virtual_sequence extends uvm_sequence#(uvm_sequence_item);
        `uvm_object_utils(virtual_sequence)

        virtual_sequencer v_seqr;
        source_sequencer s_seqr[];
        destination_sequencer d_seqr[];
        env_config e_cfg;


        function new(string name = "virtual_sequence");
                super.new(name);
        endfunction


        task body();
                if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",e_cfg))
                        `uvm_fatal("FATAL ERROR","unable to fecth the configuration file")
                $cast(v_seqr,m_sequencer);
                s_seqr = new[e_cfg.no_of_src_agent];
                d_seqr = new[e_cfg.no_of_dst_agent];
                foreach(s_seqr[i]) s_seqr[i] = v_seqr.s_seqr[i];
                foreach(d_seqr[i]) d_seqr[i] = v_seqr.d_seqr[i];
        endtask
endclass

class extnd_virtual_sequence extends virtual_sequence;
        `uvm_object_utils(extnd_virtual_sequence)

        small_packet s_pkt[];
//      dsmall_packet d_pkt[];
        soft_reset_sequence d_pkt[];

        function new(string name="extnd_virtual_sequence");
                super.new(name);
        endfunction

        task body();
                super.body;
                s_pkt = new[e_cfg.no_of_src_agent];
                foreach(s_pkt[i]) s_pkt[i] = small_packet::type_id::create($sformatf("s_pkt[%d]",i));
                d_pkt = new[e_cfg.no_of_dst_agent];
                foreach(d_pkt[i]) d_pkt[i] = soft_reset_sequence::type_id::create($sformatf("d_pkt[%d]",i));
                fork:a
                        begin
                                foreach(s_seqr[i]) s_pkt[i].start(s_seqr[i]);
                        end
                        begin
                        fork:b
                                d_pkt[0].start(d_seqr[0]);
                                d_pkt[1].start(d_seqr[1]);
                                d_pkt[2].start(d_seqr[2]);
                        join_any
                        disable b;
                end
                join
        endtask
endclass



class extnd_virtual_big_sequence extends virtual_sequence;
        `uvm_object_utils(extnd_virtual_big_sequence)

        big_packet b_pkt[];
        normal_sequence d_pkt[];

        function new(string name="extnd_virtual_big_sequence");
                super.new(name);
        endfunction

        task body();
                super.body;
                b_pkt = new[e_cfg.no_of_src_agent];
                foreach(b_pkt[i]) b_pkt[i] = big_packet::type_id::create($sformatf("b_pkt[%d]",i));
                d_pkt = new[e_cfg.no_of_dst_agent];
                foreach(d_pkt[i]) d_pkt[i] = normal_sequence::type_id::create($sformatf("d_pkt[%d]",i));
                fork:a
                        begin
                                foreach(s_seqr[i]) b_pkt[i].start(s_seqr[i]);
                        end
                        begin
                        fork:b
                                d_pkt[0].start(d_seqr[0]);
                                d_pkt[1].start(d_seqr[1]);
                                d_pkt[2].start(d_seqr[2]);
                        join_any
                        disable b;
                end
                join
        endtask
endclass

class extnd_virtual_error_sequence extends virtual_sequence;
        `uvm_object_utils(extnd_virtual_error_sequence)

        error_packet e_pkt[];
        normal_sequence d_pkt[];

        function new(string name="extnd_virtual_error_sequence");
                super.new(name);
        endfunction

        task body();
                super.body;
                e_pkt = new[e_cfg.no_of_src_agent];
                foreach(e_pkt[i]) e_pkt[i] = error_packet::type_id::create($sformatf("e_pkt[%d]",i));
                d_pkt = new[e_cfg.no_of_dst_agent];
                foreach(d_pkt[i]) d_pkt[i] = normal_sequence::type_id::create($sformatf("d_pkt[%d]",i));
                fork:a
                        begin
                                foreach(s_seqr[i]) e_pkt[i].start(s_seqr[i]);
                        end
                        begin
                        fork:b
                                d_pkt[0].start(d_seqr[0]);
                                d_pkt[1].start(d_seqr[1]);
                                d_pkt[2].start(d_seqr[2]);
                        join_any
                        disable b;
                end
                join
        endtask
endclass

                               
                                                                                   

"virtual_sequence.sv" [readonly] 156L, 5067C                          
