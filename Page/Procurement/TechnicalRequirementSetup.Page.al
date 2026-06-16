page 50763 "Technical Requirement Setup"
{
    PageType = List;
    SourceTable = "Procurement Requirement Setup";
    SourceTableView = WHERE("Evaluation Stage" = FILTER(Technical));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Needs Attachment"; Rec."Needs Attachment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."Evaluation Stage" := Rec."Evaluation Stage"::Technical;
    end;
}

