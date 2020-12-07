package com.esprit.genus.Retrofit;

import com.esprit.genus.Model.Chat;
import com.esprit.genus.Model.Game;

import java.util.List;

import io.reactivex.Observable;
import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.Path;

public interface INodeJS {

    @POST("register")
    @FormUrlEncoded
    Observable<String> registerUser(@Field("email") String email,
                                    @Field("username") String username,
                                    @Field("password") String password);

    @POST("login")
    @FormUrlEncoded
    Observable<String> loginUser(@Field("email") String email,
                                    @Field("password") String password);



    @PUT("getForgottenPassword")
    @FormUrlEncoded
    Observable<String> getForgottenPassword(@Field("email") String email);

    @PUT("/editUsername")
    @FormUrlEncoded
    Observable<String> editUsername(@Field ("idUser") int idUser,@Field("username") String username);

    @PUT("/editPassword")
    @FormUrlEncoded
    Observable<String> editPassword(@Field ("idUser") int idUser,@Field("old_password") String old_password,
                                   @Field("new_password") String new_password);


    @GET("GetGameList/{idUser}")
    Call<List<Game>> GetGameList(@Path("idUser") int idUser);

    @GET("GetChatList")
    Call<List<Chat>> GetChatList();


    @POST("search")
    @FormUrlEncoded
    Observable<List<Chat>> searchChats (@Field("search") String searchQuery);

    @POST("search")
    @FormUrlEncoded
    Observable<List<Game>> searchGames (@Field("search") String searchQuery);

    @GET("GetGameList/{idUser}")
    Call<List<Game>> GetGameListForNumber(@Path("idUser") int idUser);
    //this one for gamesNumber okay ?

    @GET("GetWishList/{idUser}")
    Call<List<Game>> GetWishList(@Path("idUser") int idUser);

    @GET("GetFavList/{idUser}")
    Call<List<Game>> GetFavList(@Path("idUser") int idUser);

    @GET("GetTrendingGames")
    Call<List<Game>> GetTrendingGames();

    @GET("GetTopPicksGames")
    Call<List<Game>> GetTopPicksGames();

    @GET("GetBestRateGames")
    Call<List<Game>> GetBestRateGames();

    @GET("GetGameDetails/{idGame}")
    Call<List<Game>> GetGameDetails (@Path("idGame") int idGame);
}
