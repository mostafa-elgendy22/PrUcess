# PrUcess
PrUcess is a processing unit that executes commands (arithmetic &amp; logic operations, memory read &amp; write operations) which are received from an external source through UART protocol.

## System Modules

### UART Transmitter

#### Block Diagram
<img src="docs/screenshots/system_design/UART/UART_transmitter/Design-UART_transmitter.png">

#### Pin Description
<table>
    <tr>
        <th>Pin</th>
        <th>Direction</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>clk</td>
        <td>input</td>
        <td>Generated clock produced from the clock divider whose source clock is UART clock</td>
    </tr>
    <tr>
        <td>reset</td>
        <td>input</td>
        <td>Global active low asynchronous reset after synchronization.</td>
    </tr>

</table>