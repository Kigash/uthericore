page 50746 "Low Value Procurement - New"
{
    // version TL2.0

    CardPageID = "Low Value Application Card";
    PageType = List;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Procurement Option" = FILTER('Low Value'),
                            "LPO Generated" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No."; Rec."Procurement Plan No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

