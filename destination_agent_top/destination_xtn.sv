class destination_xtn extends uvm_sequence_item;
        `uvm_object_utils(destination_xtn)
        bit [7:0] header;
        bit [7:0] payload[];
        bit [7:0] parity;
        rand int  no_of_cycles;

        constraint nor_seq{no_of_cycles <30 ;}

        function new(string name = "destination_xtn");
                super.new(name);
        endfunction

        function void do_print(uvm_printer printer);
                printer.print_field("header", this.header, 8, UVM_DEC);
                foreach(payload[i])
                        printer.print_field($sformatf("payload[%0d]",i), this.payload[i], 8, UVM_DEC);
                        printer.print_field("parity", this.parity, 8, UVM_DEC);
                        printer.print_field("no_of_cycles", this.no_of_cycles, 32, UVM_DEC);
        endfunction


endclass
~
