//
// myrand.zip
//
// simple random number generation
//

const std = @import("std");

pub const Prng = struct {
    rng: std.rand.DefaultPrng,

    pub fn create() Prng {
        var seed_bytes: [@sizeOf(u64)]u8 = undefined;
        std.crypto.random.bytes(seed_bytes[0..]);
        const seed = std.mem.readIntNative(u64, &seed_bytes);
        return Prng{
            .rng = std.rand.DefaultPrng.init(seed),
        };
    }

    pub fn uintLessThan(self: *Prng, comptime T: type, limit: T) T {
        return self.rng.random.uintLessThanBiased(T, limit);
    }
};
