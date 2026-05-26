# Home Assistant Add-On for LazyLibrarian

LazyLibrarian is a program to follow authors and grab metadata for all your digital
reading needs. It searches Usenet and torrent indexers, sends to your download
client, and imports/renames ebooks and audiobooks. It is the spiritual successor
to Readarr (now archived).

This add-on is a thin wrapper around the
[linuxserver/lazylibrarian](https://github.com/linuxserver/docker-lazylibrarian)
Docker image with Home Assistant Ingress support.

## Installation

1. Add the add-on repository to Home Assistant:
   `https://github.com/marciogranzotto/addons-repository`
2. Install the **LazyLibrarian** add-on.
3. Start the add-on.
4. Click **OPEN WEB UI** to access LazyLibrarian through Ingress.

[Read the full add-on documentation](lazylibrarian/DOCS.md).

## Support

Open an issue on this repository.

## License

GNU General Public License v3.0. See [LICENSE.md](LICENSE.md).
