import { axiosInstance } from '@frontend/core/services/axios';

class GeolocationsService {
  async search(input) {
    return axiosInstance
      .get('/geolocations', { params: { q: input } })
      .then(resp => resp.data.data)
  }
}

const geolocationsService = new GeolocationsService();
export default geolocationsService;
