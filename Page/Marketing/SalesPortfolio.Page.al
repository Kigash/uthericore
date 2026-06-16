page 51204 "Sales Portfolio List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Portfolio";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Recruited Members"; Rec."Recruited Members")
                {
                    ApplicationArea = All;
                }
                field("Assigned Stations"; Rec."Assigned Stations")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(RecruitedMembers)
            {
                ApplicationArea = All;
                Caption = 'Recruited Members';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CoupledCustomer;
                RunObject = page "Member List";
                RunPageLink = "Introducer Member No." = field("Member No.");
            }
        }
    }
}