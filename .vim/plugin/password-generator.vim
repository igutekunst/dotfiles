" Secure Password Generator for Vim (Crypto-secure only)
" Usage: Position cursor on line with password and call :GenSecurePassword
" Works with formats like: POSTGRES_PASSWORD=old-password
"                         password: old-password
"                         "password": "old-password"

function! GenerateSecurePassword(length)
    " Try to use system's cryptographic random source
    if executable('openssl')
        let l:password = system('openssl rand -base64 ' . (a:length * 3 / 4 + 1))
        let l:password = substitute(l:password, '[^A-Za-z0-9]', '', 'g')
        let l:password = l:password[:a:length-1]
        
        " If we didn't get enough characters, pad with secure random
        while len(l:password) < a:length
            let l:extra = system('openssl rand -base64 10')
            let l:extra = substitute(l:extra, '[^A-Za-z0-9]', '', 'g')
            let l:password .= l:extra
        endwhile
        
        return l:password[:a:length-1]
    elseif executable('python3')
        " Use Python's secrets module for cryptographically secure random
        let l:python_cmd = 'python3 -c "import secrets, string; print(\"\".join(secrets.choice(string.ascii_letters + string.digits + \"!@#$%^&*()_+-=\") for _ in range(' . a:length . ')))"'
        return substitute(system(l:python_cmd), '\n', '', 'g')
    else
        echohl ErrorMsg
        echo "Error: Neither openssl nor python3 found. Cannot generate cryptographically secure password."
        echohl None
        return ""
    endif
endfunction

function! ReplacePasswordOnLine()
    let l:current_line = getline('.')
    let l:new_password = GenerateSecurePassword(64)
    
    " Exit if password generation failed
    if l:new_password == ""
        return
    endif
    
    " Pattern matching for different password formats
    " Format 1: KEY=value
    if match(l:current_line, '^\s*[A-Z_][A-Z0-9_]*\s*=') != -1
        let l:new_line = substitute(l:current_line, '=.*$', '=' . l:new_password, '')
    " Format 2: key: value (YAML style)
    elseif match(l:current_line, '^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*:') != -1
        let l:new_line = substitute(l:current_line, ':\s*.*$', ': ' . l:new_password, '')
    " Format 3: "key": "value" (JSON style)
    elseif match(l:current_line, '^\s*"[^"]*"\s*:') != -1
        let l:new_line = substitute(l:current_line, ':\s*"[^"]*"', ': "' . l:new_password . '"', '')
    " Format 4: key="value" or key='value'
    elseif match(l:current_line, '^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*=\s*["\']') != -1
        let l:quote = matchstr(l:current_line, '["\']')
        let l:new_line = substitute(l:current_line, '=\s*["\'][^"\']*["\']', '=' . l:quote . l:new_password . l:quote, '')
    else
        echohl ErrorMsg
        echo "Could not detect password format on current line"
        echohl None
        return
    endif
    
    " Replace the line
    call setline('.', l:new_line)
    echo "Password replaced with cryptographically secure 24-character password"
endfunction

" Commands
command! GenSecurePassword call ReplacePasswordOnLine()

