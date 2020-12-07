package com.esprit.genus.Adapter;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.esprit.genus.Model.Game;
import com.esprit.genus.R;

import java.io.File;
import java.util.List;

public class GameVerticalAdapter extends RecyclerView.Adapter<GameVerticalAdapter.MyViewHolder> {

    List<Game> gameList;
    Context mContext;
    public GameVerticalAdapter(Context mContext,List<Game> gameList) {
        this.mContext = mContext;
        this.gameList = gameList;
    }

    @NonNull
    @Override
    public GameVerticalAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.gamevertical_layout, parent, false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull GameVerticalAdapter.MyViewHolder holder, int position) {




        Glide.with(mContext).load("http://10.0.2.2:3000/image/"+gameList.get(position).getGamePicture()).into(holder.gamePic);
        holder.gameName.setText(gameList.get(position).getName());
        holder.gameStudio.setText("by "+gameList.get(position).getCompanyName());
    }

    @Override
    public int getItemCount() {
        return gameList.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {

        CardView root_view;
        TextView gameName, gameStudio;
        ImageView gamePic;

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);

            root_view = (CardView) itemView.findViewById(R.id.root_view);
            gamePic = (ImageView) itemView.findViewById(R.id.gamePic);
            gameName = (TextView) itemView.findViewById(R.id.txt_name);
            gameStudio = (TextView) itemView.findViewById(R.id.txt_companyname);
        }
    }
}
