OUTPUT_ARCH( "riscv" )
ENTRY( _entry )

SECTIONS
{
  /*
   * ensure that entry.S / _entry is at 0x80000000,
   * where qemu's -kernel jumps.
   */
  . = 0x80000000;
  .text :
  {
	*(entry)
    *(.text)
    . = ALIGN(0x1000);
    *(trampsec)
  }

  . = ALIGN(0x1000);
  PROVIDE(etext = .);

  /*
   * make sure end is after data and bss.
   */
  .data : {
    *(.data)
  }
  .bss : {
    *(.bss)
    *(.sbss*)
     PROVIDE(end = .);
  }
  _stack_top = ALIGN(0x1000);
    . = _stack_top + 0x100000;
  _stack_pointer = .;
  end = .;
  _end = .;
  _heap_start = ALIGN(0x1000);
}
