class sbase_sequence extends uvm_sequence#(source_xtn);
        `uvm_object_utils(sbase_sequence)
        function new(string name = "sbase_sequence");
                super.new(name);
        endfunction
endclass

class small_packet extends sbase_sequence;
        `uvm_object_utils(small_packet)

        function new(string name="small_packet");
                super.new(name);
        endfunction

        task body();
                req = source_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {header[7:2] == 6'd10;});
                finish_item(req);
        endtask
endclass

class medium_packet extends sbase_sequence;
        `uvm_object_utils(medium_packet)

        function new(string name = "medium_packet");
                super.new(name);
        endfunction

        task body();
                req = source_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {header[7:2] == 6'd15;});
                finish_item(req);
        endtask
endclass

class big_packet extends sbase_sequence;
        `uvm_object_utils(big_packet)

        function new(string name ="big_packet");
                super.new(name);
        endfunction

        task body();
                req = source_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {header[7:2] == 6'd55;});
                finish_item(req);
        endtask
endclass

class error_packet extends sbase_sequence;
        `uvm_object_utils(error_packet)

        function new(string name ="error_packet");
                super.new(name);
        endfunction

        task body();
                req = source_xtn::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {header[7:2] == 6'd10;});
                req.parity = 8'd1;
                finish_item(req);
        endtask

endclass
                              
