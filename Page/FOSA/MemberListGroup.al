page 50017 MemberListGroup
{

    // version TL2.0

    Caption = 'Members';
    CardPageID = "Member Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Related Information,Approval Request,Category 6,Category 7,Category 8';
    SourceTable = Member;
    SourceTableView = SORTING("No.") ORDER(Ascending) WHERE(Category = FILTER(Group));
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

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
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }

                /*  field(Surname; Surname)
                 {
                     ApplicationArea = All;
                 }
                 field("First Name"; Rec."First Name")
                 {
                     ApplicationArea = All;
                 }
                 field("Last Name"; Rec."Last Name")
                 {
                     ApplicationArea = All;
                 } */
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Age Classification"; Rec."Age Classification")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    ApplicationArea = All;
                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Old Member Status"; Rec."Old Member Status")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Page; 50041)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Member Nominees")
            {
                Ellipsis = true;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::Nominee);
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50005, BeneficiaryType);
                end;
            }
            action("Next of Kin")
            {
                Ellipsis = true;
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Next of Kin");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50006, BeneficiaryType);
                end;
            }
            action(Agencies)
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Agency.FILTERGROUP(10);
                    Agency.SETRANGE("Member No.", Rec."No.");
                    Agency.FILTERGROUP(0);
                    PAGE.RUN(50052, Agency);
                end;
            }
            action("Monthly Contributions")
            {
                Ellipsis = true;
                Image = ElectronicPayment;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MemberMonthlyContribution.FILTERGROUP(10);
                    MemberMonthlyContribution.SETRANGE("Application No.", Rec."Application No.");
                    Agency.FILTERGROUP(0);
                    PAGE.RUN(50053, MemberMonthlyContribution);
                end;
            }
            action("Group Members")
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Group Member");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50057, BeneficiaryType);
                end;
            }
            action("Group Trustees")
            {
                Image = Trace;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Group Trustee");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50059, BeneficiaryType);
                end;
            }
            action("Company Signatories")
            {
                Image = Company;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleCompany;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Company Signatory");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50056, BeneficiaryType);
                end;
            }
            action("Company Trustees")
            {
                Image = Signature;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleCompany;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Company Trustee");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50058, BeneficiaryType);
                end;
            }
            action("Joint Members")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleJoint;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Joint Member");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50071, BeneficiaryType);
                end;
            }
            action("Savings/Deposit Accounts")
            {
                Image = SocialListening;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Vendor.FILTERGROUP(10);
                    Vendor.SETRANGE("Member No.", Rec."No.");
                    Vendor.FILTERGROUP(0);
                    PAGE.RUN(50033, Vendor);
                end;
            }
            action("Loan Accounts")
            {
                Image = SocialListening;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Message('Loan Accounts');
                    LoanAc.FILTERGROUP(10);
                    LoanAc.Reset();
                    LoanAc.SETRANGE("Member No.", Rec."No.");
                    LoanAc.FILTERGROUP(0);
                    PAGE.RUN(50207, LoanAc);
                end;
            }
            group(Reports)
            {
                action(Statement)
                {
                    Image = SocialListening;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Vendor.FILTERGROUP(10);
                        Vendor.SETRANGE("Member No.", Rec."No.");
                        Vendor.FILTERGROUP(0);
                        Report.RUN(50082, true, false, Vendor);
                    end;
                }

                action(LoanStatement)
                {
                    Caption = 'Loan Statement';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        LoanApplication.FILTERGROUP(10);
                        LoanApplication.SETRANGE("Member No.", Rec."No.");
                        LoanApplication.FILTERGROUP(0);
                        Report.RUN(50081, true, false, LoanApplication);
                    end;
                }
                action("Member Statement-Combined")
                {
                    Caption = 'Member Statement-Combined';
                    Image = BankAccountStatement;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Member: Record Member;
                    begin
                        Member.FILTERGROUP(10);
                        Member.SETRANGE("No.", Rec."No.");
                        Member.FILTERGROUP(0);
                        Report.RUN(50087, true, false, Member);
                    end;
                }
                action("UpdateStatus")
                {
                    Caption = 'Update Member Status';
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Member: Record Member;
                        Vend: Record Vendor;
                        DVend: Record "Detailed Vendor Ledg. Entry";
                    begin
                        Member.Reset();
                        if Member.FindSet() then begin
                            repeat
                                if (Member.Status = Member.Status::Active) or (Member.Status = Member.Status::Dormant) then begin
                                    Vend.Reset();
                                    Vend.SetRange(Vend."Member No.", Member."No.");
                                    Vend.SetRange(Vend."Account Type", '02');
                                    Vend.SetRange(Vend.Status, Vend.Status::Active, Vend.Status::Dormant);
                                    if Vend.FindFirst() then begin
                                        DVend.Reset();
                                        DVend.SetRange(DVend."Vendor No.", Vend."No.");
                                        DVend.SetFilter(DVend."Credit Amount", '>%1', 0);
                                        If DVend.FindLast() then begin
                                            if DVend."Posting Date" <= CalcDate('-3M', Today) then begin
                                                Vend.Status := Vend.Status::Dormant;
                                            end else begin
                                                Vend.Status := Vend.Status::Active;
                                            end;
                                        end;

                                        DVend.Reset();
                                        DVend.SetRange(DVend."Vendor No.", Vend."No.");
                                        DVend.SetFilter(DVend."Credit Amount", '>%1', 0);
                                        If not DVend.FindLast() then begin
                                            Vend.Status := Vend.Status::Dormant;
                                        end;

                                        Vend.Modify();
                                    end;
                                    Member.Modify;
                                end;
                            until Member.Next = 0;
                        end;
                        Message('Update complete');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetVisible;
        SetEditable;
    end;

    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
        /*Member.Reset();
         Member.SetRange(Member."Section Name", '');
         if Member.FindSet() then begin
             repeat
                 ChurchSection := '';

                 ChrchSect.Reset();
                 ChrchSect.SetRange(ChrchSect.Code, Member."Church Section Code");

                 if ChrchSect.FindFirst() then begin
                     // Member."Section Name" := ChrchSect.Name;
                     // Member.Modify();
                 end;
             until Member.Next = 0;
         end;*/
    end;



    var
        BeneficiaryType: Record "Beneficiary Type";
        ChurchSection: text[150];
        LoanAc: Record "Loan Application";
        ChrchSect: Record "Church Section";
        //ApprovalsMgmt: Codeunit "1535";
        [InDataSet]
        IsVisibleIndividual: Boolean;
        [InDataSet]
        IsVisibleGroup: Boolean;
        [InDataSet]
        IsVisibleCompany: Boolean;
        Member: Record Member;
        IsVisibleApprovalRequest: Boolean;
        Agency: Record "Member Agency";
        MemberMonthlyContribution: Record "Member Contribution";
        IsVisibleJoint: Boolean;
        IsVisibleSignature: Boolean;
        [InDataSet]
        IsVisiblePicture: Boolean;
        [InDataSet]
        IsVisibleFrontID: Boolean;
        [InDataSet]
        IsVisibleBackID: Boolean;
        IsVisibleCR: Boolean;
        Vendor: Record "Vendor";
        Customer: Record "Customer";
        LoanApplication: Record "Loan Application";

    local procedure SetVisible()
    begin
        IF Rec.Category = Rec.Category::Individual THEN BEGIN
            IsVisibleGroup := FALSE;
            IsVisibleCompany := FALSE;
            IsVisibleIndividual := TRUE;
            IsVisibleJoint := FALSE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := TRUE;
            IsVisibleBackID := TRUE;
            IsVisibleFrontID := TRUE;
            IsVisibleCR := FALSE;
        END ELSE
            IF Rec.Category = Rec.Category::Group THEN BEGIN
                IsVisibleIndividual := FALSE;
                IsVisibleCompany := FALSE;
                IsVisibleGroup := TRUE;
                IsVisibleJoint := FALSE;
                IsVisiblePicture := TRUE;
                IsVisibleSignature := FALSE;
                IsVisibleFrontID := FALSE;
                IsVisibleBackID := FALSE;
                IsVisibleCR := TRUE;
            END ELSE
                IF Rec.Category = Rec.Category::Company THEN BEGIN
                    IsVisibleIndividual := FALSE;
                    IsVisibleGroup := FALSE;
                    IsVisibleCompany := TRUE;
                    IsVisibleJoint := FALSE;
                    IsVisiblePicture := TRUE;
                    IsVisibleSignature := FALSE;
                    IsVisibleFrontID := FALSE;
                    IsVisibleBackID := FALSE;
                    IsVisibleCR := TRUE;
                END ELSE
                    IF Rec.Category = Rec.Category::Joint THEN BEGIN
                        IsVisibleGroup := FALSE;
                        IsVisibleCompany := FALSE;
                        IsVisibleIndividual := FALSE;
                        IsVisibleJoint := TRUE;
                        IsVisiblePicture := TRUE;
                        IsVisibleSignature := FALSE;
                        IsVisibleFrontID := FALSE;
                        IsVisibleBackID := FALSE;
                        IsVisibleCR := FALSE;
                    END;
        IF Rec.Status = Rec.Status::Active THEN
            IsVisibleApprovalRequest := TRUE
        ELSE
            IsVisibleApprovalRequest := FALSE
    end;

    local procedure SetEditable()
    begin
        IF Rec.Status = Rec.Status::Active THEN
            CurrPage.EDITABLE := TRUE;
        IF Rec.Status = Rec.Status::Dormant THEN
            CurrPage.EDITABLE := FALSE;
        IF Rec.Status = Rec.Status::Suspended THEN
            CurrPage.EDITABLE := FALSE;
    end;

}