CREATE TABLE UniqueId (
	maxId int NOT NULL ,
	tableName varchar(100) NOT NULL
);

    create table PdcAxisValue (
        axisId bigint not null,
        valueId bigint not null,
        primary key (axisId, valueId)
    );

    create table PdcClassification (
        id bigint generated by default as identity,
        contentId varchar(255),
        instanceId varchar(255) not null,
        modifiable bit not null,
        nodeId varchar(255),
        primary key (id)
    );

    create table PdcClassification_PdcPosition (
        PdcClassification_id bigint not null,
        positions_id bigint not null,
        primary key (PdcClassification_id, positions_id),
        unique (positions_id)
    );

    create table PdcPosition (
        id bigint generated by default as identity,
        primary key (id)
    );

    create table PdcPosition_PdcAxisValue (
        PdcPosition_id bigint not null,
        axisValues_axisId bigint not null,
        axisValues_valueId bigint not null,
        primary key (PdcPosition_id, axisValues_axisId, axisValues_valueId)
    );

    alter table PdcClassification_PdcPosition 
        add constraint FKDB93406E747FC777 
        foreign key (positions_id) 
        references PdcPosition;

    alter table PdcClassification_PdcPosition 
        add constraint FKDB93406E8EE2BDA9 
        foreign key (PdcClassification_id) 
        references PdcClassification;

    alter table PdcPosition_PdcAxisValue 
        add constraint FK978A70086022C209 
        foreign key (PdcPosition_id) 
        references PdcPosition;

    alter table PdcPosition_PdcAxisValue 
        add constraint FK978A7008C0EBF31A 
        foreign key (axisValues_axisId, axisValues_valueId) 
        references PdcAxisValue;