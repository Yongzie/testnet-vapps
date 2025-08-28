module my_sui_poc::hello_world {

    use sui::object;
    use sui::tx_context::TxContext;
    use sui::transfer;
    use std::string;

    /// Struct untuk menyimpan pesan
    public struct MessageBoard has key {
        id: object::UID,
        message: string::String,
    }

    /// Init object pertama kali (dipanggil saat publish)
    fun init(ctx: &mut TxContext) {
        let board = MessageBoard {
            id: object::new(ctx),
            message: string::utf8(b"Hello from Sui!"),
        };
        transfer::share_object(board); // bikin shared object biar bisa diakses siapa aja
    }

    /// Fungsi untuk update pesan
    public fun say_hello(board: &mut MessageBoard, msg: string::String) {
        board.message = msg;
    }

    /// Getter untuk baca pesan
    public fun get_message(board: &MessageBoard): &string::String {
        &board.message
    }
}

