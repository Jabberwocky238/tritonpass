//! `triton-arith-to-linalg` 的 `grid-encoding` 选项：`program_id` / `num_programs` 怎么表达。
/// grid 的表达：`gpu`：`gpu.block_id`、`gpu.grid_dim`（缺省）；`args`：函数末尾追加 6 个 i32 参数。
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum GridEncoding {
    #[default]
    Gpu,
    Args,
}

impl GridEncoding {
    const TABLE: [(Self, &'static str); 2] = [(Self::Gpu, "gpu"), (Self::Args, "args")];

    pub const fn name(self) -> &'static str {
        Self::TABLE[self as usize].1
    }
}

impl TryFrom<&str> for GridEncoding {
    type Error = mlirformat::Error;
    /// 空串是缺省（gpu）。
    fn try_from(s: &str) -> Result<Self, Self::Error> {
        if s.is_empty() {
            return Ok(Self::Gpu);
        }
        Self::TABLE.iter().find(|(_, n)| *n == s).map(|(g, _)| *g).ok_or_else(|| mlirformat::Error::from(format!("grid-encoding 只认 gpu 或 args，不认「{s}」")))
    }
}
