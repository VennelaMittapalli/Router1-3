class source_xtn extends uvm_sequence_item;
        `uvm_object_utils(source_xtn)
        rand bit [7:0] header;
        rand bit [7:0] payload[];
        bit [7:0] parity;
        bit error;

        constraint valid_addr{header[1:0] != 2'b11;}
        constraint valid_length{header[7:2] != 6'd0;}
        constraint valid_size{payload.size == header[7:2];}
        //constraint valid_con{header[7:2] == 6'd10;}
        function new(string name = "source_xtn");
                super.new(name);
        endfunction

        function void do_print(uvm_printer printer);
                printer.print_field("Header",this.header,8,UVM_DEC);
                foreach(payload[i])
                printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);
                printer.print_field("Parity",this.parity,8,UVM_DEC);
                printer.print_field("Error",this.error,1,UVM_DEC);
        endfunction

        function void post_randomize();
                parity = header;
                foreach(payload[i]) parity = payload[i]^parity;
        endfunction
endclass
~
~
~
~
