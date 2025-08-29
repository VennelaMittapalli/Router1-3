class scoreboard extends uvm_scoreboard;
        `uvm_component_utils(scoreboard)

        source_xtn src_xtn;
        destination_xtn dst_xtn;

        uvm_tlm_analysis_fifo#(source_xtn) src_fifo[];
        uvm_tlm_analysis_fifo#(destination_xtn) dst_fifo[];

        env_config e_cfg;

               covergroup src_cfg;
        ADDR: coverpoint src_xtn.header[1:0]{
                                        bins addr1 = {2'b00};
                                        bins addr2 = {2'b01};
                                        bins addr3 = {2'b10};
                                        }
        PAYLOAD: coverpoint src_xtn.header[7:2] {
                                        bins small_p = {[1:15]};
                                        bins medium_p =  {[16:30]};
                                        bins big_p = {[31:63]};}

//      ERROR1: coverpoint src_xtn.error {[0:1]};

        CROSSAPE: cross ADDR,PAYLOAD;
        endgroup

        covergroup dst_cfg;
        ADDR: coverpoint dst_xtn.header[1:0]{
                                        bins addr1 = {2'b00};
                                        bins addr2 = {2'b01};
                                        bins addr3 = {2'b10};}
        PAYLOAD: coverpoint dst_xtn.header[7:2] {
                                        bins small_p = {[1:15]};
                                        bins medium_p = {[16:30]};
                                        bins big_p = {[31:63]};}
        CROSSAP: cross ADDR,PAYLOAD;
        endgroup


        function new(string name = "scoreboard", uvm_component parent);
                super.new(name, parent);
                src_cfg = new();
                dst_cfg = new();
        endfunction

        function void build_phase(uvm_phase phase);
          if(!uvm_config_db#(env_config)::get(this,"","env_config",e_cfg))
                        `uvm_fatal("FATAL ERROR","Unable to fetch configuration file")

                src_fifo = new[e_cfg.no_of_src_agent];
                dst_fifo= new[e_cfg.no_of_dst_agent];
                foreach(src_fifo[i]) src_fifo[i] = new($sformatf("src_fifo[%0d]",i),this);
                foreach(dst_fifo[i]) dst_fifo[i] = new($sformatf("dst_fifo[%0d]",i),this);
        //      src_cfg = new("src_cfg",this);

                super.build_phase(phase);
        endfunction
 task run_phase(uvm_phase phase);
                forever begin
                        fork begin
                                src_fifo[0].get(src_xtn);
                                src_xtn.print();
                                src_cfg.sample();
                        end
                begin
                        fork begin
                                dst_fifo[0].get(dst_xtn);
                                dst_xtn.print();
                                dst_cfg.sample();
                        end
                        begin
                                dst_fifo[1].get(dst_xtn);
                                dst_xtn.print();
                                dst_cfg.sample();
                        end
                        begin
                                dst_fifo[2].get(dst_xtn);
                                dst_xtn.print();
                                dst_cfg.sample();
                        end
                        join_any
                        disable fork;
                end
                join
                        compareinput(src_xtn, dst_xtn);
                //join
                end
        endtask


        task compareinput(source_xtn src_xtn, destination_xtn dst_xtn);
                if(src_xtn.header == dst_xtn.header)
                        $display("ADDRESS COMPARED");
                else
                        $display("FAIL MESSAGE");
                if(src_xtn.payload == dst_xtn.payload)
                        $display("SUCCESS MESSAGE");
                else
                        $display("FAIL MESSAGE");
                if(src_xtn.parity == dst_xtn.parity)
                        $display("SUCCESS");
                        $display("SUCCESS");
                else
                        $display("FAIL");
        endtask


endclass
            
                                                                                          
"scoreboard.sv" 138L, 3725C                                             
