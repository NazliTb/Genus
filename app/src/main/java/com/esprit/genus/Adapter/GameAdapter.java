package com.esprit.genus.Adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.esprit.genus.GamePictureShape.RoundRectCornerImageView;
import com.esprit.genus.GamescreenActivity;
import com.esprit.genus.Interfaces.IGameClickListener;
import com.esprit.genus.Model.Game;
import com.esprit.genus.R;

import java.util.List;

public class GameAdapter extends RecyclerView.Adapter<GameAdapter.MyViewHolder> {

    List<Game> gameList;
    Context mContext;
    
    public GameAdapter(Context mContext,List<Game> gameList) {
        this.gameList = gameList;
        this.mContext= mContext;
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.game_layout, parent, false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {
        Glide.with(mContext).load("http://10.0.2.2:3000/image/"+gameList.get(position).getGamePicture()).into(holder.gamePic);
        holder.gameName.setText(gameList.get(position).getName());
        holder.gameStudio.setText("by "+gameList.get(position).getCompanyName());
        holder.gameType.setText(gameList.get(position).getType());
        holder.gameDate.setText(gameList.get(position).getReleaseDate().toString());

        holder.setGameClickListener(new IGameClickListener() {
            @Override
            public void onGameClick(View view, int position) {
                Toast.makeText(mContext, ""+gameList.get(position).getName(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public int getItemCount() {
        return gameList.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        CardView root_view;
        TextView gameName, gameStudio, gameType, gameDate;
        RoundRectCornerImageView gamePic;


        IGameClickListener gameClickListener;

        public void setGameClickListener(IGameClickListener gameClickListener) {
            this.gameClickListener = gameClickListener;
        }

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);
            mContext = itemView.getContext();

            root_view = (CardView) itemView.findViewById(R.id.root_view);
            gamePic = (RoundRectCornerImageView) itemView.findViewById(R.id.gamePic);
            gameName = (TextView) itemView.findViewById(R.id.txt_name);
            gameStudio = (TextView) itemView.findViewById(R.id.txt_companyname);
            gameType = (TextView) itemView.findViewById(R.id.txt_type);
            gameDate = (TextView) itemView.findViewById(R.id.txt_date);

            itemView.setOnClickListener(this);

        }

        @Override
        public void onClick(View v) {
            gameClickListener.onGameClick(v, getAdapterPosition());
            Intent intent;
            intent = new Intent(mContext, GamescreenActivity.class);
            mContext.startActivity(intent);
        }
    }
}
