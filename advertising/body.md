Dieser Text wurde kopiert und automatisch hochgeladen. Da der Account von anobel mir (Achim Mertens) gehört, habe ich mich selber plagiiert ;-)

Hallo liebe Hiveaner,

(english see below)

heute ist für mich ein ganz besonderer Tag. Ich habe es nach jahrelangem Lernen und Ausprobieren geschafft, mit Hilfe eines Javascriptprogrammes in die Hive Blockchain hinein zu schreiben. Das ist für mich ein riesiger Meilenstein, der höchste Programmier-Gipfel, auf dem ich je gestanden habe.


![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/243BaLCioq4WURRvC9oNyRwcdkkej7h5yx6W9oG7KTFJn7aNVJ54TBFvjWKFc7hZxQyBw.png)
*Dieses Bild wurde erschaffen mit https://creator.nightcafe.studio/*

Ich will euch natürlich nicht vorenthalten wie es geht. Im nachhinein sieht es ja auch ganz leicht aus ;-)

# Upvote
Hier ist mein Javascript Code um ein Upvote an ein bestehenden Post zu geben:
```
import hive from '@hiveio/hive-js';
const privateKey = '5J...';
hive.api.setOptions({ url: 'https://api.hive.blog' });
const voter = 'anobel';
const author = 'achimmertens';
const permlink = 'weekly-statistics-for-the-beerbot-rvz3l6';
hive.broadcast.vote(
  privateKey,
  voter,
  author,
  permlink,
  5000, // entspricht 50% Upvote
  function(err, result) {
    console.log(err, result);
  }
);
```

Diesen Code habe ich in eine Datei namens vote.js gespeichert. Die liegt in einem Projektordner, der mit Github verbunden ist. D.h. ihr könnt den Code [hier](https://github.com/achimmertens/HiveTokenELK/blob/dev/advertising/vote.js) im Original sehen.

Nach dem Erstellen des Scripts muss Node aktuallisiert werden, bzw. das hive-js Modul geladen werden:
>$ npm i @hiveio/hive-js

Damit aber noch nicht genug (bei mir). Wegen der Fehlermeldung: 
```
	$ node vote.js
	(node:4488) Warning: To load an ES module, set "type": "module" in the package.json or use the .mjs extension. 
```
musste ich dann noch in die package.json hinzufügen:
>"type": "module",

![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/23tRtfuVtrow7tx1AAMSmw344vqdcE3haQ9QxLWjN9QUBkv3tnHFbmw6zRvoydUQsy1Fw.png)

Nun kann man das Script wie folgt ausführen:
>$ node vote.js

Man erhält eine Rückbestätigung:
```
null {
  id: 'd2c36097286aa26c965205c3080fd98e9579d8ab',
  ref_block_num: 12506,
  ref_block_prefix: 1667678884,
  expiration: '2023-06-15T04:43:03',
  operations: [ [ 'vote', [Object] ] ],
  extensions: [],
  signatures: [
    '1f56a8a4d779f39c6f1eaf1448960999f550c725cbad46cae228468d603043dfb130adf7b2e6e0d57bf7dcaf00918c0a22f6aeb8c70718c08b006124a6c3608973'
  ]
}
```

Und tatsächlich erkennt man, dass der Voter "anobel" in der Peakd-Ansicht erscheint:


![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/EoCbQWV6ERiPFKXhAjj8wdq9Y2tXZgHQbfDPSany21udav4cg2Amfhj7ZRvuEXp6TDU.png)

Aber damit nicht genug. Jetzt will ich mehr.

# Kommentar

Mit folgendem Code bin ich in der Lage einen Kommentar zu schreiben:
```
import hive from '@hiveio/hive-js';
import config from './config.js';
const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });
const parentAuthor = 'achimmertens';
const parentPermlink = 'weekly-statistics-for-the-beerbot-rvz3l6';
const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = '';
const body = 'Hallo, hier ist anobel. Dies ist mein erster Kommentar seit langem.';
hive.broadcast.comment(
  privateKey,
  parentAuthor,
  parentPermlink,
  author,
  permlink,
  title,
  body,
  { tags: ['test'], app: 'test/0.1' },
  function(err, result) {
    console.log(err, result);
  }
);
```

Und Tadaaa, hier ist das Ergebnis:

![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/Eo6Cd53RT8UaZkfzRPxjWVG5bx4uwcijxRp2rqroCRuV4MfzV9kAwrEGWyL8dfS2qtV.png)

# Wie geht es weiter
Da mir nun viele Türen offen stehen, möchte ich auch ausprobieren, wie man ganze Posts erstellt (Soll einfach sein, indem man einen Titel im Kommentarfeld einfügt). Ich möchte aber auch automatisiert Hive und Nobel-Token verschicken können. Ich habe da ein paar Ideen, die sind aber noch nicht Spruchreif.

# Fazit:
Der Damm ist gebrochen. 

![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/23xyQuvKbrhEzWgLKyUjXD4Etw4sVgQRckJaiogB4fwx2zqjA1mQcHZ6378DNGMpJDsBN.png)
*origin: https://dreamlike.art/create*

Ich kann nun meine [Reports](https://peakd.com/@achimmertens?filter=stats), die ich tatsächlich (teilautomatisiert erstelle und) noch von Hand in die Blockchain schreibe, zumindest im Prinzip ganz automatisieren. Sicher sind da noch weitere Berge zu erklimmen, aber der wichtigste Schritt ist jetzt getan.

Im Übrigen bin ich sehr dankbar für die neuen Möglichkeiten der KI. Ohne ChatGPT bzw. Bing hätte es wohl deutlich länger gedauert, um an diese Ergebnisse zu kommen. Allerdings spucken diese neuen Intelligenzen nicht auf Anhieb raus was gewünscht ist oder funktionert. Aber mit ein bischen Backgroundwissen und Einlesen in die [Hive-API](https://developers.hive.io/apidefinitions/#apidefinitions-condenser-api) und [Hive-Doku](https://developers.hive.io/tutorials-javascript/vote_on_content.html) kommt man dann irgendwann doch voran.

Ich habe da schon lange darauf hin gearbeitet und bin so glücklich, dass ich heute Abend zusammen mit meiner Frau eine Flasche Sekt aufmache.



![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/244eVMDXKfcGpijQndZiCZYj8wR8YHEsc1yhfZaomunWRjAE11PpF6L4nfEfbcNs6uUKK.png)
*origin: https://dreamlike.art/create*

In diesem Sinne: Prost!


-----------------
# English

Hello dear Hiveans,

today is a very special day for me. After years of learning and trying, I managed to write into the Hive blockchain using a Javascript program. This is a huge milestone for me, the highest programming summit I've ever stood on.


![graphic.png](https://files.peakd.com/file/peakd-hive/achimmertens/243BaLCioq4WURRvC9oNyRwcdkkej7h5yx6W9oG7KTFJn7aNVJ54TBFvjWKFc7hZxQyBw.png)
*This image was created with https://creator.nightcafe.studio/*

Of course I don't want to withhold from you how it's done. In hindsight it looks easy ;-)

# Upvote
Here is my javascript code to upvote an existing post:
```
import hive from '@hiveio/hive-js';
const privateKey = '5J...';
hive.api.setOptions({ url: 'https://api.hive.blog' });
const voter = 'anobel';
const author = 'achimmertens';
const permlink = 'weekly-statistics-for-the-beerbot-rvz3l6';
hive.broadcast.vote(
   private key,
   voter,
   author,
   permlink,
   5000, // equals 50% upvote
   function(err, result) {
     console.log(err, result);
   }
);
```

I saved this code in a file called vote.js. It's in a project folder connected to Github. That means you can see the original code [here](https://github.com/achimmertens/HiveTokenELK/blob/dev/advertising/vote.js).

After creating the script, Node must be updated or the hive-js module must be loaded:
>$npm i @hiveio/hive-js

But that's not all (for me). Because of the error message:
```
$ node vote.js
(node:4488) Warning: To load an ES module, set "type": "module" in the package.json or use the .mjs extension.
```
I then had to add to the package.json:
>"type": "module",

![graphic.png](https://files.peakd.com/file/peakd-hive/achimmertens/23tRtfuVtrow7tx1AAMSmw344vqdcE3haQ9QxLWjN9QUBkv3tnHFbmw6zRvoydUQsy1Fw.png)

Now you can run the script as follows:
>$ node vote.js

You will receive a confirmation:
```
null {
   ID: 'd2c36097286aa26c965205c3080fd98e9579d8ab',
   ref_block_num: 12506,
   ref_block_prefix: 1667678884,
   expiration: '2023-06-15T04:43:03',
   operations: [ [ 'vote', [Object] ] ],
   extensions: [],
   signatures: [
     '1f56a8a4d779f39c6f1eaf1448960999f550c725cbad46cae228468d603043dfb130adf7b2e6e0d57bf7dcaf00918c0a22f6aeb8c70718c08b006124a6c3608 973'
   ]
}
```

And indeed you can see that the voter "anobel" appears in the Peakd view:


![graphic.png](https://files.peakd.com/file/peakd-hive/achimmertens/EoCbQWV6ERiPFKXhAjj8wdq9Y2tXZgHQbfDPSany21udav4cg2Amfhj7ZRvuEXp6TDU.png)

But that's not all. Now I want more.

# comment

With the following code I am able to write a comment:
```
import hive from '@hiveio/hive-js';
import config from './config.js';
const privateKey = config.privateKey;
hive.api.setOptions({ url: 'https://api.hive.blog' });
const parentAuthor = 'achimmertens';
const parentPermlink = 'weekly-statistics-for-the-beerbot-rvz3l6';
const author = 'anobel';
const permlink = new Date().toISOString().replace(/[^a-zA-Z0-9]+/g, '').toLowerCase();
const title = '';
const body = 'Hello, this is anobel. This is my first comment in a long time.';
hive.broadcast.comment(
   private key,
   parentAuthor,
   parentPermLink,
   author,
   permlink,
   title,
   body,
   { tags: ['test'], app: 'test/0.1' },
   function(err, result) {
     console.log(err, result);
   }
);
```

And tadaaa, here is the result:

![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/Eo6Cd53RT8UaZkfzRPxjWVG5bx4uwcijxRp2rqroCRuV4MfzV9kAwrEGWyL8dfS2qtV.png)

# What's next
Now that many doors are open to me, I would also like to try how to create whole posts (should be easy by putting a title in the comment field). But I would also like to be able to send Hive and Nobel tokens automatically. I have a few ideas, but they're not ready for decision yet.

# Conclusion:
The dam has broken.

![graphic.png](https://files.peakd.com/file/peakd-hive/achimmertens/23xyQuvKbrhEzWgLKyUjXD4Etw4sVgQRckJaiogB4fwx2zqjA1mQcHZ6378DNGMpJDsBN.png)
*origin: https://dreamlike.art/create*

I can now fully automate my [reports](https://peakd.com/@achimmertens?filter=stats), which I actually create (partially automatically and) still write into the blockchain by hand, at least in principle. There are certainly more mountains to climb, but the most important step has now been taken.

Incidentally, I am very grateful for the new possibilities of AI. Without ChatGPT or Bing it would have taken much longer to get these results. However, these new intelligences do not immediately spit out what is desired or works. But with a bit of background knowledge and reading into the [Hive-API](https://developers.hive.io/apidefinitions/#apidefinitions-condenser-api) and [Hive-doku](https://developers.hive.io/tutorials-javascript/vote_on_content.html) you get there.

I've been working toward this for a long time and I'm so happy that I'm opening a bottle of sparkling wine with my wife tonight.


![grafik.png](https://files.peakd.com/file/peakd-hive/achimmertens/244eVMDXKfcGpijQndZiCZYj8wR8YHEsc1yhfZaomunWRjAE11PpF6L4nfEfbcNs6uUKK.png)
*origin: https://dreamlike.art/create*

Cheers, Anobel

