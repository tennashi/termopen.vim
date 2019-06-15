# termopen.vim
Provides Terminal-api functions for opening files from terminal mode.

# Install
## vim-plug
```
Plug 'tennashi/termopen.vim'
```

# API
## `Tapi_open`
`Tapi_open` opens `<file_name>`.

### Request
```json
["call", "Tapi_open", [<open_cmd>, <file_name>]]
```

### `<open_cmd>`
`<open_cmd>` specifies the vim command when opening with vim.

  * `open`
  * `edit`
  * `drop`
  * `split`
  * `vsplit`
  * `tabnew`

## `Tapi_open_wait`
`Tapi_open_wait` opens `<file_name>` and returns `<wait_string>` when editing is complete.

### Request
```
["call", "Tapi_open_wait", [<open_cmd>, <res_id>, <file_name>]]
```

### Response
```
{"res_id": <res_id>, "msg": "done"}
```

### `<open_cmd>`
`<open_cmd>` specifies the vim command when opening with vim.

  * `open`
  * `edit`
  * `drop`
  * `split`
  * `vsplit`
  * `tabnew`

### Example
```bash
echo -e "\x1b]51;[\"call\", \"Tapi_open_wait\", [\"edit\", \"response_id\", \"hoge\"]]\x07"

while :
do
  read res
  if [ "${res}" = "{\"res_id\":\"response_id\",\"msg\":\"done\"}" ]; then
    exit
  fi
done
```
