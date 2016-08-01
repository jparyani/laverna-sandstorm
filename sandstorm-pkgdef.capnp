@0xe8750674e4f4a7a6;

using Spk = import "/sandstorm/package.capnp";
# This imports:
#   $SANDSTORM_HOME/latest/usr/include/sandstorm/package.capnp
# Check out that file to see the full, documented package definition format.

const pkgdef :Spk.PackageDefinition = (
  # The package definition. Note that the spk tool looks specifically for the
  # "pkgdef" constant.

  id = "4dgxs5m0gnjmjpg88mswqsy9fj08t3z6c8kwv4y9tkgxvp9eas9h",
  # Your app ID is actually its public key. The private key was placed in
  # your keyring. All updates must be signed with the same key.

  manifest = (
    # This manifest is included in your app package to tell Sandstorm
    # about your app.

    appTitle = (defaultText = "Laverna"),

    appVersion = 13,  # Increment this for every release.

    appMarketingVersion = (defaultText = "0.6.3-git"),

    actions = [
      # Define your "new document" handlers here.
      ( title = (defaultText = "New Laverna Instance"),
        nounPhrase = (defaultText = "notebook"),
        command = .myCommand
        # The command to run when starting for the first time. (".myCommand"
        # is just a constant defined at the bottom of the file.)
      )
    ],

    continueCommand = .myCommand,
    # This is the command called to start your app back up after it has been
    # shut down for inactivity. Here we're using the same command as for
    # starting a new instance, but you could use different commands for each
    # case.+
    metadata = (
      icons = (
        appGrid = (svg = embed "app-graphics/laverna-128.svg"),
        grain = (svg = embed "app-graphics/laverna-24.svg"),
        market = (svg = embed "app-graphics/laverna-150.svg"),
      ),

      website = "https://laverna.cc/",
      codeUrl = "https://github.com/jparyani/laverna",
      license = (openSource = gpl3),
      categories = [productivity], # TODO(more)

      author = (
        contactEmail = "jparyani@sandstorm.io",
        pgpSignature = embed "pgp-signature",
        upstreamAuthor = "Laverna Team",
      ),
      pgpKeyring = embed "pgp-keyring",

      description = (defaultText = embed "description.md"),
      shortDescription = (defaultText = "Note-taking"),

      screenshots = [
        (width = 448, height = 248, png = embed "sandstorm-screenshot.png")
      ],
    ),
  ),

  sourceMap = (
    # Here we define where to look for files to copy into your package.
    searchPath = [
      ( packagePath = "server", sourcePath = "server" ),
      # Map server binary at "/server".

      ( packagePath = "client", sourcePath = "laverna/dist" ),
      # Map client directory at "/client".

      ( sourcePath = "empty" )
      # Make sure / is mapped to work around Sandstorm bug (temporary).
    ]
  ),

  fileList = "sandstorm-files.list",
  # `spk dev` will write a list of all the files your app uses to this file.
  # You should review it later, before shipping your app.

  alwaysInclude = [ "." ]
  # Fill this list with more names of files or directories that should be
  # included in your package, even if not listed in sandstorm-files.list.
  # Use this to force-include stuff that you know you need but which may
  # not have been detected as a dependency during `spk dev`. If you list
  # a directory here, its entire contents will be included recursively.
);

const myCommand :Spk.Manifest.Command = (
  # Here we define the command used to start up your server.
  argv = ["/server"],
  environ = [
    # Note that this defines the *entire* environment seen by your app.
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/bin")
  ]
);
