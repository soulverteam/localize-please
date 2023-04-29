# localize-please
#### Automatic localization of your Mac or iOS app using the ChatGPT API

## Motivation
Supporting multiple languages in a Mac or iOS app is a drag, because as you add new features or tweak existing ones, you need to continually update the strings for every language you support (which can involve waiting on translators, etc).

This tool uses OpenAI's GPT APIs (which are excellent at context-aware translation) to make update all your strings or xloc files for all your supported languages, just by running a single command.

## What does Localize, Please do?

`localize-please` is a command-line tool that automatically translates the text content of your Mac or iOS app, using OpenAI's GPT language model.

Use `localize-please` to translate your app into a new language, or update an existing localization whenever you add a new feature.

Supported file types for automatic localization include:

- .strings (Xcode's standard file type for localizable strings)
- .stringsdict (used by Xcode for handling pluralization cases)
- .xcloc (the file type produced when you export your localizations from Xcode) 
- .txt (Plain text) 
- .md (Markdown)

`localize-please` is incremental (by default), which means it only translates the strings that appear untranslated, saving you time (and money!).

## Requirements

- `localize-please` requires an OpenAI API Key, which you can get for free from [here](https://platform.openai.com/account/api-keys)
- OpenAI offers a free quota of API requests for new accounts

## Installation
Download the binary of the latest version of the `localize-please` command line tool from the Releases section.

### Setup

Run the `set-api-key` command with your OpenAI API key (this only needs to be done once):

```bash
localize-please set-api-key "sk-EXAMPLE-KEY-1234567890"
```

## Usage

Run the `localize-please` command with a path to an Xcode project folder (the folder that contains lproj folders):

```bash
localize-please "/Users/zac/Projects/MyCoolApp/"
```
or with a folder contining .xloc files, created by Xcode's `Export Localizations…` command:

```bash
localize-please "/Users/zac/Desktop/Exported Localizations/"
```

`localize-please` will automatically translate any strings that appear untranslated using OpenAI's GPT language model.

## Additional options

-  `-o, --output-folder <output-folder>`: Specify a folder to save translated files into. Without this set, the original localizable files will be edited in place.
-  `-l, --language <ISO 639-1 language code (de, fr, ja, etc)>`: Limit translation to only the specified language. By default all language folders/files detected will be translated).
-  `-q, --quiet`: Prevent translations from being printed to the console as the tool runs.
-  `-f, --force-translate`: Disables incremental localization. All strings in the project will be sent off for re-translation, even if they already appear translated.
-  `--api-key <OpenAI API Key>`: Specify an API key to be used for this particular localization request.

## Accuracy & error handling

OpenAI's GPT language model is very good at translating and understands the context that informs an accurate translation.

If OpenAI's GPT language model fails to translate a particular string for any reason, the original translation will be left untouched.

## Performance
The OpenAI ChatGPT API currently translates about 2 strings/second. So please be patient the first time you run the tool on a completely new language for your project.

`localize-please` is incremental, and further invocations of the tool will attempt to translate only the strings that appear untranslated.

## Why should I use localize-please instead of ChatGPT directly?
There are a few reasons:
- ChatGPT can only handle a certain amount of input in a single query, whereas `localize-please` splits your files up into chunks
- ChatGPT sometimes messes up the translation format. `localize-please` does its best to keep the format of translations correct and not mess up the formatting of your files
- Copying and pasting is boring: `localize-please` is a single command that works across multiple files and languages from one command

## Should I only rely on this tool for my translations?
Even though ChatGPT does very good translations, it's still worth checking your translation with native speakers.

It's still more time efficient to first translate a project automatically using a good AI service, and then fix the odd issue, than for a human localizer to translate an entire project from scratch.

## Avoiding ambiguity in translations

Some strings can be ambiguous without further clarification. For instance:

```strings
"Empty" = "Empty";
```

It's not clear whether this string is an imperative verb (like "**Empty** the trash!") or an adjective "The folder is **empty**".

To provide a translator (or in this case, ChatGPT) with the required context to deliver an accurate translation, you can add a localizer comment

```strings
/* Empty the trash */
"Empty" = "Empty";
```

If you're using .xcloc files (Xcode's Export Localizations feature), make sure you specify a comment for the localizer when defining your string.

#### General

```swift
   let string = String(localized: "Empty", comment: "Empty the Trash")
```

#### SwiftUI views

```swift
    Text("Empty",
         comment: "Empty the trash")
```

#### Storyboards
Specify the comment under in the "Localizer Hint" property for the label or control.

## Tips
-  `localize-please` also works with plain text and markdown (`.md`) files. So you can automatically translate your release notes for an update by including a `release-notes.md` file in your project as a localized file.

## Mac app with GUI?
A Mac app that offers a nice GUI around this tool is in development. It will be available later this year.

## License
This project is licensed under the terms of the MIT license. See [LICENSE](LICENSE) for more information.

## Warranty
This project is provided as-is and without warranty of any kind, express or implied, including but not limited to fitness for a particular purpose, non-infringement, and absence of errors or inaccuracies. The author and any contributors to this project shall not be liable for any damages, including but not limited to direct, indirect, incidental, or consequential damages, arising from the use of this project or from any content or information accessed through this project.
