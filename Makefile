build:
	cargo build --target wasm32-unknown-unknown --release
	wasm-strip ./target/wasm32-unknown-unknown/release/counter_kernel.wasm
	
	smart-rollup-installer get-reveal-installer \
	--upgrade-to ./target/wasm32-unknown-unknown/release/counter_kernel.wasm \
	--output ./installer_output/installer.wasm \
	--preimages-dir ./installer_output/preimages
	
	wasm-strip ./installer_output/installer.wasm

debug-installer:
	octez-smart-rollup-wasm-debugger ./installer_output/installer.wasm --inputs ./debug/inputs.json --preimage-dir ./installer_output/preimages

debug-main:
	octez-smart-rollup-wasm-debugger ./target/wasm32-unknown-unknown/release/counter_kernel.wasm --inputs ./debug/inputs.json