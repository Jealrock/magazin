import store from '@/store/store';

const requireOfferOwnership = async function(to, from, next) {
  const offerUserId = store.getters.getOffer.user_id;
  const userId = store.getters.currentUser.id;

  if (offerUserId && userId && offerUserId === userId)
    return next();
  else
    return next('/');
}

export default requireOfferOwnership;
