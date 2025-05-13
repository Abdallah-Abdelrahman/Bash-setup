local F = {}

function F.formatHTML()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.html",
    callback = function()
      -- Run Prettier asynchronously
      vim.fn.jobstart("prettier --write "..vim.fn.expand('%'), {
        on_exit = function(_, exit_code)
          if exit_code == 0 then
            -- Reload the buffer after Prettier formats the file
            vim.cmd("edit!")
          else
            vim.notify("Prettier formatting failed!", vim.log.levels.ERROR)
          end
        end
      })
    end
  })
end

function F.setup()
  F.formatHTML()
end

return F
