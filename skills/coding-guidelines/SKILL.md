---
name: coding-guidelines
description: Linee guida di scrittura del codice valide per tutti i progetti (lingua del codice, firme dei metodi, commenti e testi). Da leggere integralmente prima di OGNI modifica al codice, anche minima.
---

# Linee guida di scrittura del codice (tutti i progetti)

**Prima di ogni modifica (anche di una sola riga) leggi per intero le linee guida SAP e quelle qui sotto, senza saltare sezioni e senza fidarti di quanto letto in precedenza nella conversazione.**

## 0. Linee guida SAP (da leggere ogni volta)

Prima di ogni modifica chiama il tool MCP `get_guidelines` del server `sapui5` e leggi il risultato per intero. Le linee guida SAP hanno la precedenza su queste regole in caso di conflitto, tranne che per la lingua del codice, dei commenti e dei testi (sezioni 1-4).

Se le modifiche toccano il codice UI5, usa anche i tool dello stesso server come indicato nelle linee guida SAP (per esempio `get_api_reference` per le API e `run_ui5_linter` per la validazione).

## 1. Codice in inglese

Tutto il codice è scritto in inglese:

- nomi di variabili, costanti, funzioni, metodi, classi, interfacce e tipi
- nomi di file e cartelle
- chiavi dei file i18n (le chiavi sono in inglese, i valori sono in italiano, vedi sezione 4)
- nomi di eventi, modelli, proprietà dei modelli JSON e ID delle view

## 2. Firma di ogni metodo con breve spiegazione

Ogni metodo, funzione o handler deve avere sopra la firma un commento JSDoc con una breve spiegazione (una o due righe) di cosa fa. Il testo della spiegazione è in italiano (vedi sezione 3).
Descrivi anche parametri e valore di ritorno quando non sono ovvi dal nome o dal tipo.

```ts
/**
 * Carica i template dal servizio e li imposta nel modello della view.
 * @param sFilterValue testo da usare per filtrare l'elenco
 * @returns promise risolta a caricamento terminato
 */
public async loadTemplates(sFilterValue: string): Promise<void> {
    // ...
}
```

## 3. Commenti e testi in italiano

- Tutti i commenti (JSDoc, commenti di riga e di blocco, commenti XML e nei `.properties`) sono in italiano.
- Tutti i testi visibili all'utente sono in italiano: etichette, titoli, pulsanti, messaggi, tooltip, errori.
- Fa eccezione solo il caso in cui l'utente chieda esplicitamente un'altra lingua per una specifica richiesta. L'eccezione vale solo per quella richiesta, non diventa la regola.

## 4. Testi nei file i18n

- Nessun testo scritto direttamente nelle view o nel codice: ogni testo passa dal file i18n.
- Le chiavi sono in inglese (sezione 1), i valori in italiano (sezione 3).
- Ogni chiave nuova va aggiunta a tutti i file di lingua esistenti (`i18n.properties`, `i18n_en.properties`, ecc.).
- Sopra ogni chiave metti l'annotazione SAP del tipo di testo (`#XTIT`, `#XBUT`, `#XFLD`, `#XMSG`, `#XTOL`, ...), con lunghezza massima e nota per i traduttori quando servono.

## 5. Variabili in Hungarian notation

Variabili, parametri e proprietà private usano un prefisso minuscolo che indica il tipo, seguito dal nome in camelCase inglese (sezione 1):

| Prefisso | Tipo | Esempio |
|---|---|---|
| `s` | string | `sFilterValue` |
| `i` | integer | `iIndex` |
| `f` | float | `fAmount` |
| `b` | boolean | `bIsVisible` |
| `o` | object | `oModel`, `oEvent` |
| `a` | array | `aItems` |
| `m` | map / oggetto chiave-valore | `mParameters` |
| `fn` | function | `fnCallback` |
| `d` | date | `dStartDate` |
| `r` | regular expression | `rPattern` |
| `p` | promise | `pLoad` |
| `v` | tipo variabile / any | `vValue` |
| `$` | oggetto jQuery | `$Element` |

- Vale per variabili locali, parametri di metodi/funzioni e campi delle classi.
- Le costanti a livello di modulo restano in `UPPER_SNAKE_CASE`; nomi di metodi, classi e tipi non hanno prefisso.
- Anche in TypeScript, dove il tipo è già dichiarato, il prefisso va usato comunque.
