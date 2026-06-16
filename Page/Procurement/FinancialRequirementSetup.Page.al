page 50762 "Financial Requirement Setup"
{
    PageType = List;
    SourceTable = "Procurement Requirement Setup";
    SourceTableView = WHERE("Evaluation Stage" = FILTER(Financial));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    Editable = false;
                    ApplicationArea = All;
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
        Rec."Evaluation Stage" := Rec."Evaluation Stage"::Financial;
    end;
}

