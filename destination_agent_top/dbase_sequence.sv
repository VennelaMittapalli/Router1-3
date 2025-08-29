class dbase_sequence extends uvm_sequence#(destination_xtn);
        `uvm_object_utils(dbase_sequence)
        function new(string name = "dbase_sequence");
                super.new(name);
        endfunction
endclass


class normal_sequence extends dbase_sequence;
        `uvm_object_utils(normal_sequence)

        function new(string name="normal_sequence");
                super.new(name);
        endfunction

        task body();
                req = destination_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize());
                finish_item(req);
        endtask
endclass

class soft_reset_sequence extends dbase_sequence;
         `uvm_object_utils(soft_reset_sequence)

        function new(string name = "soft_reset_sequence");
                super.new(name);
        endfunction

        task body();
                req = destination_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize());
                finish_item(req);
        endtask
endclass
~
