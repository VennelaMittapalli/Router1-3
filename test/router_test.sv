class router_test extends uvm_test;
`uvm_component_utils(router_test)
env_config cfg;
source_agent_config src_cfg[];
destination_agent_config dst_cfg[];
int no_of_src_agent=1;
int no_of_dst_agent=3;
//int has_scoreboard=1;
//int has_virtual_sequencer=1;
tb envh;
function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
endfunction
extern function new(string name="router_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
//extern task run_phase(uvm_phase);

endclass

function router_test:: new(string name="router_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test:: build_phase(uvm_phase phase);
        dst_cfg=new[no_of_dst_agent];
        src_cfg=new[no_of_src_agent];
        cfg=env_config::type_id::create("cfg");
        cfg.dst_cfg=new[no_of_dst_agent];
        cfg.src_cfg=new[no_of_src_agent];
        foreach(src_cfg[i])
        begin
                src_cfg[i]=source_agent_config::type_id::create($sformatf("src_cfg[%0d]",i));
                if(!uvm_config_db #(virtual router_if)::get(this,"","src",src_cfg[i].vif))
                        `uvm_fatal("TEST","cannot get config data");
                src_cfg[i].is_active=UVM_ACTIVE;
                cfg.src_cfg[i]=src_cfg[i];
        end
        foreach(dst_cfg[i])
        begin
                dst_cfg[i]=destination_agent_config::type_id::create($sformatf("r_cfg[%0d]",i));
                if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("dst[%0d]",i),dst_cfg[i].vif))
                        `uvm_fatal("TEST","cannot get config data");
                dst_cfg[i].is_active=UVM_ACTIVE;
                cfg.dst_cfg[i]=dst_cfg[i];
        end
        cfg.no_of_src_agent=no_of_src_agent;
        cfg.no_of_dst_agent=no_of_dst_agent;
        cfg.src_cfg=new[no_of_src_agent];
        foreach(src_cfg[i])
        begin
                src_cfg[i]=source_agent_config::type_id::create($sformatf("src_cfg[%0d]",i));
                if(!uvm_config_db #(virtual router_if)::get(this,"","src",src_cfg[i].vif))
                        `uvm_fatal("TEST","cannot get config data");
                src_cfg[i].is_active=UVM_ACTIVE;
                cfg.src_cfg[i]=src_cfg[i];
        end
        foreach(dst_cfg[i])
        begin
                dst_cfg[i]=destination_agent_config::type_id::create($sformatf("r_cfg[%0d]",i));
                if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("dst[%0d]",i),dst_cfg[i].vif))
                        `uvm_fatal("TEST","cannot get config data");
                dst_cfg[i].is_active=UVM_ACTIVE;
                cfg.dst_cfg[i]=dst_cfg[i];
        end
        cfg.no_of_src_agent=no_of_src_agent;
        cfg.no_of_dst_agent=no_of_dst_agent;
//      cfg.has_scoreboard=has_scoreboard;
//      cfg.has_virtual_sequencer=has_virtual_sequencer;
        uvm_config_db#(env_config)::set(this,"*","env_config",cfg);
        super.build_phase(phase);
        envh=tb::type_id::create("envh",this);
endfunction

class router_test_c1 extends router_test;
`uvm_component_utils(router_test_c1)
extnd_virtual_sequence v_seq;

extern function new(string name="router_test_c1",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_c1:: new(string name="router_test_c1",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_c1::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_c1::run_phase(uvm_phase phase);
        v_seq=extnd_virtual_sequence::type_id::create("v_seq");
        phase.raise_objection(this);

        v_seq.start(envh.v_seqr);
        #200;
        phase.drop_objection(this);
endtask





class router_test_c2 extends router_test;
`uvm_component_utils(router_test_c2)
extnd_virtual_medium_sequence v_seq;

extern function new(string name="router_test_c2",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_c2:: new(string name="router_test_c2",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_c2::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_c2::run_phase(uvm_phase phase);
        v_seq=extnd_virtual_medium_sequence::type_id::create("v_seq");
        phase.raise_objection(this);
        v_seq.start(envh.v_seqr);
        #100;
        phase.drop_objection(this);
endtask







class router_test_c3 extends router_test;
`uvm_component_utils(router_test_c3)
extnd_virtual_big_sequence v_seq;

extern function new(string name="router_test_c3",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_c3:: new(string name="router_test_c3",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_c3::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_c3::run_phase(uvm_phase phase);
        v_seq=extnd_virtual_big_sequence::type_id::create("v_seq");
        phase.raise_objection(this);

        v_seq.start(envh.v_seqr);
        #100;
        phase.drop_objection(this);
endtask




class router_test_c4 extends router_test;
`uvm_component_utils(router_test_c4)
extnd_virtual_error_sequence v_seq;

extern function new(string name="router_test_c4",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_c4:: new(string name="router_test_c4",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_c4::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_c4::run_phase(uvm_phase phase);
        v_seq=extnd_virtual_error_sequence::type_id::create("v_seq");
        phase.raise_objection(this);

        v_seq.start(envh.v_seqr);
        #100;
        phase.drop_objection(this);
endtask

                                         
                                                       


