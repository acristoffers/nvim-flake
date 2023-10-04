This is my personal NeoVim configuration managed by a nix flake.
It's meant to be very simple and straightforward, with the added benefit of
having all external tools (like LSP's) managed by nix too, so it is a single
package manager for both vim plugins and the external tools.

As of now it works but the lua side really needs a rewrite. After porting I did
not test every single plugin, so it may even be that some are not even being
correctly loaded... But it is mostly working anyways. Maybe I'll fix it in
December.
