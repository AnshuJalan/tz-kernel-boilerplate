use tezos_smart_rollup_entrypoint::kernel_entry;
use tezos_smart_rollup_host::runtime::Runtime;

pub fn entry<Host: Runtime>(host: &mut Host) {
    host.write_debug("Hello, Kernel!\n");
    execute(host);
}

fn execute<Host: Runtime>(host: &mut Host) {
    let input = host.read_input();

    match input {
        Err(_) | Ok(None) => (),
        Ok(Some(msg)) => {
            let data = msg.as_ref();
            match data {
                [0x00, ..] => {
                    host.write_debug("Rollup Message!\n");
                }
                [0x01, ..] => {
                    host.write_debug("User Message!\n");
                }
                _ => execute(host),
            }
        }
    }

    execute(host)
}

kernel_entry!(entry);
