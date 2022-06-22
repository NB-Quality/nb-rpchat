fx_version 'cerulean'
game 'gta5'
author 'negbook'

lua54 'yes'

client_scripts {
    'sounds.lua',
}
shared_scripts{
    'config.lua',
    'callback.lua',
    'rpchat.lua'
}

dependencies {
    'chat'
}

files {
    "style.css"
}


chat_theme 'nb-rpchat' {
    styleSheet = 'style.css'

}

