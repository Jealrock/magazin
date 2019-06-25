const DEFAULT_LOCALE = 'ru';

class TranslationService {
  translate(lang) {
    document.cookie="googtrans=/ru/" + lang;
    document.cookie="googtrans=/ru/" + lang + "; domain=." + document.domain;
    window.location.reload();
  }

  reset() {
    document.cookie="googtrans="
    document.cookie="googtrans= ; domain=." + document.domain;
    window.location.reload();
  }

  currentLocale() {
    const cookies = document.cookie.split('; ')
      .map((cook) => cook.split('='))

    const googleCookie = cookies.find((cook) => cook[0] === 'googtrans');

    if (!googleCookie) return DEFAULT_LOCALE;

    return googleCookie[1] ? googleCookie[1].substr(4, 2) : DEFAULT_LOCALE;
  }
}

const translateService = new TranslationService();
export default translateService;
