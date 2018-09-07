//
//  NetworkMiddleware.swift
//  LastFMReduxState
//
//  Created by Oleksii Shvachenko on 8/28/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ReSwift

func load(service: NetworkSessionManager) -> Middleware {
  return { load(action: $0, context: $1, service: service) }
}

private func load(action: Action, context: MiddlewareContext<AppState>, service: NetworkSessionManager) -> Action? {
//  guard
//    let loadAlbumsAction = action as? ArtistState.Actions,
//    case .loadAlbums(let artistMbid) = loadAlbumsAction else {
//      return action
//  }
//  let api = API.topAlbums(for: artistMbid)
//  service.objectRequest(api) { (result: Result<TopAlbums>) in
//    switch result {
//    case .success(let albums):
//      context.dispatch(ArtistState.Actions.setAlbums(albums.albums))
//    case .failure(let error):
//      context.dispatch(ErrorState.Actions.errorMessage(error.stringValue))
//    }
//  }
  return action
}
